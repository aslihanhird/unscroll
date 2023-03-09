require 'open-uri'

class TwitterPostsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    list.twitter_profiles.each do |profile|
      profile.twitter_posts.each(&:destroy)
      response = posts_from_api(profile.twitter_id)
      if call_successful?(response)
        posts_data = response['data']['user']['result']['timeline']['timeline']['instructions'][1]['entries']
        posts_data.first(15).each { |post| post_maker(post, profile) }
      end
    end
    redirect_to list_path(list)
  end

  private

  def call_successful?(response)
    errors = ["error", "fail"]
    return false if errors.include?(response['status'])

    true
  end

  def posts_from_api(id)
    url = "https://twitter135.p.rapidapi.com/UserTweets/?id=#{id}&count=15"
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    JSON.parse(response.body)
  end

  def post_maker(post, profile)
    return unless post['content']['entryType'] == 'TimelineTimelineItem'

    @trim_post = post['content']['itemContent']['tweet_results']['result']['legacy']
    @new_post = base_post_maker(@trim_post, profile)


    if @trim_post.key?('extended_entities')
      if @trim_post['entities']['media'][0]['type'] == 'photo'
        @new_post.media_url = @trim_post['entities']['media'][0]['media_url_https']
        @new_post.photo.attach(io: URI.open(@new_post.media_url), filename: "#post-content.png", content_type: "image/png")
      else
        @new_post.media_url = 'none'
      end
    else
      @new_post.media_url = 'none'
    end
    @new_post.save
  end

  def base_post_maker(post, profile)
    @new_post = TwitterPost.new
    @new_post.caption = post['full_text']
    @new_post.timestamp = format_timestamp(post['created_at'])
    @new_post.twitter_profile = profile
    return @new_post
  end

  def format_timestamp(timestamp)
    date = Time.parse(timestamp)
    date.to_i.to_s
  end

end

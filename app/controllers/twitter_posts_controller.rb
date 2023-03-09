class TwitterPostsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    list.twitter_profiles.each do |profile|
      profile.twitter_posts.each(&:destroy)
      response = posts_from_api(profile.twitter_id)
      if call_successful?(response)
        posts_data = response['data']['user']['results']['timeline']['timeline']['instructions'][1]['entries']
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
    new_post = base_post_maker(post, profile)

    case post['node']['__typename']
    when "GraphImage"
      new_post.media_url = post['node']['display_url']
      new_post.photo.attach(io: URI.open(new_post.media_url), filename: "#{new_post.id}-content.png", content_type: "image/png")
    when "GraphVideo"
      new_post.media_url = post['node']['video_url']
      new_post.video.attach(io: URI.open(new_post.media_url), filename: "#{new_post.id}-content.mp4", content_type: "video/mp4")
    else
      # eventually, carousel
      return
    end

    new_post.save
  end

  def base_post_maker(post, profile)
    if post['content']['entry_type'] == 'TimelineTImelineItem'
      new_post = TwitterPost.new
      new_post.caption = post[‘content’][‘itemContent’][‘tweet_results’][‘results’][‘legacy’][‘full_text’]
      new_post.timestamp = format_timestamp(post[‘content’][‘itemContent’][‘tweet_results’][‘results’][‘legacy’][‘created_at’])
      new_post.twitter_profile = profile
    end
    new_post
  end

  def format_timestamp(timestamp)
    date = Time.new(timestamp)
    date.to_i.to_s
  end
end

end

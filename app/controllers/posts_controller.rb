require "open-uri"

class PostsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    list.profiles.each do |profile|
      profile.posts.each(&:destroy)
      response = call_api(profile.profile_source_id, profile.profile_type)
      if call_successful?(response)
        case profile.profile_type
        when 'twitter'
          posts_data = response['data']['user']['result']['timeline']['timeline']['instructions'][1]['entries']
          posts_data.first(15).each { |post| twitter_post_maker(post, profile) }
        when 'instagram'
          posts_data = response['data']['user']['edge_owner_to_timeline_media']['edges']
          posts_data.first(15).each { |post| insta_post_maker(post, profile) }
        end
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

  def call_api(id, source)
    case source
    when 'twitter'
      url = "https://twitter135.p.rapidapi.com/UserTweets/?id=#{id}&count=15"
    when 'instagram'
      url = "https://instagram-data12.p.rapidapi.com/user/posts/?user_id=#{id}"
    end
    request_posts_from_api(url)
  end

  def request_posts_from_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    JSON.parse(response.body)
  end

  def twitter_post_maker(post, profile)
    return unless post['content']['entryType'] == 'TimelineTimelineItem'

    trim_post = post['content']['itemContent']['tweet_results']['result']['legacy']
    new_post = base_twitter_post_maker(trim_post, profile)

    if trim_post.key?('extended_entities') && trim_post['entities']['media'][0]['type'] == 'photo'
      media_url = trim_post['entities']['media'][0]['media_url_https']
      new_post.photo.attach(io: URI.open(media_url), filename: "#post-content.png", content_type: "image/png")
    end
    new_post.save
  end

  def base_twitter_post_maker(post, profile)
    new_post = Post.new
    new_post.caption = post['full_text']
    new_post.timestamp = format_timestamp(post['created_at'])
    new_post.profile = profile
    new_post
  end

  def format_timestamp(timestamp)
    date = Time.parse(timestamp)
    date.to_i
  end

  def insta_post_maker(post, profile)
    new_post = base_insta_post_maker(post, profile)

    case post['node']['__typename']
    when "GraphImage"
      media_url = post['node']['display_url']
      new_post.photo.attach(io: URI.open(media_url), filename: "#{new_post.id}-content.png", content_type: "image/png")
    when "GraphVideo"
      media_url = post['node']['video_url']
      new_post.video.attach(io: URI.open(media_url), filename: "#{new_post.id}-content.mp4", content_type: "video/mp4")
    else
      # eventually, carousel
      return
    end

    new_post.save
  end

  def base_insta_post_maker(post, profile)
    new_post = InstaPost.new
    if post['node']['edge_media_to_caption']['edges'].empty?
      new_post.caption = "No caption"
    else
      new_post.caption = post['node']['edge_media_to_caption']['edges'][0]["node"]['text']
    end
    new_post.timestamp = post['node']['taken_at_timestamp']
    new_post.profile = profile
    new_post
  end
end

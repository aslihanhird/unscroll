require "open-uri"

class InstaPostsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    list.insta_profiles.each do |profile|
      profile.insta_posts.each(&:destroy)
      response = posts_from_api(profile.insta_id)
      if call_successful?(response)
        posts_data = response['data']['user']['edge_owner_to_timeline_media']['edges']
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
    url = "https://instagram-data12.p.rapidapi.com/user/posts/?user_id=#{id}"
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
    new_post = InstaPost.new
    if post['node']['edge_media_to_caption']['edges'].empty?
      new_post.caption = "No caption"
    else
      new_post.caption = post['node']['edge_media_to_caption']['edges'][0]["node"]['text']
    end
    new_post.timestamp = post['node']['taken_at_timestamp']
    new_post.insta_profile = profile
    new_post
  end
end

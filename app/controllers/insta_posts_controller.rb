require "open-uri"

class InstaPostsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    list.insta_profiles.each do |profile|
      profile.insta_posts.each { |post| post.destroy }
      posts_data = posts_from_api(profile.insta_id)
      if posts_data
        posts_data.select! { |post| post['node']['__typename'] == "GraphImage" }
        posts_data.first(5).each { |post| post_maker(post, profile) }
      end
    end
  end


  private

  def posts_from_api(id)
    errors = ["error", "fail"]
    url = "https://instagram-data12.p.rapidapi.com/user/posts/?user_id=#{id}"
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )

    parse_result = JSON.parse(response.body)
    if errors.include?(parse_result['status'])
      return false
    end

    parse_result['data']['user']['edge_owner_to_timeline_media']['edges']
  end

  def post_maker(post, profile)
    new_post = InstaPost.new()
    if post['node']['edge_media_to_caption']['edges'].empty?
      new_post.caption = "No caption"
    else
      new_post.caption = post['node']['edge_media_to_caption']['edges'][0]["node"]['text']
    end
    new_post.media_url = post['node']['display_url']
    new_post.timestamp = post['node']['taken_at_timestamp']
    new_post.insta_profile = profile
    new_post.save
    file = URI.open(new_post.media_url)
    new_post.photo.attach(io: file, filename: "#{new_post.id}-content.png", content_type: "image/png")
    p new_post.photo
  end
end

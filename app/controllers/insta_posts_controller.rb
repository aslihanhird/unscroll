class InstaPostsController < ApplicationController
  def create
    list = List.find(params[:list_id])
    list.insta_profiles.each do |profile|
      posts_data = posts_from_api(profile.insta_id)
      posts_data.first(5).each { |post| post_maker(post) } if posts_data
      end
    end
  end


  private

  def posts_from_api(id)
    url = "https://instagram-data12.p.rapidapi.com/user/posts/?user_id=#{id}"
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    # return 'error' if response.status != 200

    parse_result = JSON.parse(response.body)
    return false if parse_result['status'] == "error"

    parse_result['data']['user']['edge_owner_to_timeline_media']['edges']
  end

  def post_maker(post)
    new_post = InstaPost.new()
    new_post.caption = post['node']['edge_media_to_caption']['edges'][0]["node"]['text']
    new_post.media_url = post['node']['display_url']
    new_post.timestamp = post['node']['taken_at_timestamp']
    new_post.insta_profile = profile
    new_post.save
  end

end

require "open-uri"

class Profile < ApplicationRecord
  belongs_to :list

  has_many :posts
  has_one_attached :photo

  validates :username, presence: true

  def refresh
    posts.where(favourite: false).delete_all
    response = call_api
    case profile_type
    when 'twitter'
      posts_data = response['data']['user']['result']['timeline']['timeline']['instructions'][1]['entries']
      posts_data.first(15).each { |post| twitter_post_maker(post) }
    when 'instagram'
      posts_data = response['data']['user']['edge_owner_to_timeline_media']['edges']
      posts_data.first(2).each { |post| insta_post_maker(post) }
    end
  end


  private

  def call_api
    case profile_type
    when 'twitter'
      url = "https://twitter135.p.rapidapi.com/UserTweets/?id=#{profile_source_id}&count=3"
    when 'instagram'
      url = "https://instagram-data12.p.rapidapi.com/user/posts/?user_id=#{profile_source_id}"
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

  def twitter_post_maker(post)
    return unless post['content']['entryType'] == 'TimelineTimelineItem'

    trim_post = post['content']['itemContent']['tweet_results']['result']['legacy']
    new_post = base_twitter_post_maker(trim_post)

    if trim_post.key?('extended_entities') && trim_post['entities']['media'][0]['type'] == 'photo'
      media_url = trim_post['entities']['media'][0]['media_url_https']
      new_post.photos.attach(io: URI.open(media_url), filename: "#post-content.png", content_type: "image/png")
      new_post.media_type = "photo"
    end
    new_post.save
  end

  def base_twitter_post_maker(post)
    new_post = Post.new
    new_post.caption = post['full_text']
    new_post.timestamp = format_timestamp(post['created_at'])
    new_post.profile = self
    new_post.source = 'twitter'
    new_post
  end

  def format_timestamp(timestamp)
    date = Time.parse(timestamp)
    date.to_i
  end

  def insta_post_maker(post)
    new_post = base_insta_post_maker(post)

    case post['node']['__typename']
    when "GraphImage"
      media_url = post['node']['display_url']
      new_post.photos.attach(io: URI.open(media_url), filename: "#{new_post.id}-content.png", content_type: "image/png")
      new_post.media_type = "photo"
    when "GraphVideo"
      media_url = post['node']['video_url']
      new_post.videos.attach(io: URI.open(media_url), filename: "#{new_post.id}-content.mp4", content_type: "video/mp4")
      new_post.media_type = "video"
    when "GraphSidecar"
      new_post.media_type = 'carousel'
      new_post.media_keys = insta_carousel_keys(new_post, post['node']['edge_sidecar_to_children']['edges'])
    end
    new_post.save
  end

  def base_insta_post_maker(post)
    new_post = Post.new
    if post['node']['edge_media_to_caption']['edges'].empty?
      new_post.caption = ""
    else
      new_post.caption = post['node']['edge_media_to_caption']['edges'][0]["node"]['text']
    end
    new_post.timestamp = post['node']['taken_at_timestamp'].to_i
    new_post.profile = self
    new_post.source = 'instagram'
    new_post
  end

  def insta_carousel_keys(new_post, children)
    array = []
    i = 1
    children.each do |child|
      case child['node']['__typename']
      when "GraphImage"
        new_post.photos.attach(io: URI.open(child['node']['display_url']), filename: "#{i}-content.png", content_type: "image/png")
        array << 'photo'
      when "GraphVideo"
        new_post.videos.attach(io: URI.open(child['node']['video_url']), filename: "#{i}-content.png", content_type: "video/mp4")
        array << 'video'
      end
      i += 1
    end
    array
  end
end

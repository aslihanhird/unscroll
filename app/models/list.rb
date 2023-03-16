class List < ApplicationRecord
  belongs_to :user

  has_many :profiles

  has_many :posts, through: :profiles

  validates :name, presence: true

  def new_posts
    posts = []
    profiles.each do |profile|
      profile.posts.each do |post|
        posts.push(post) unless post.favourite? || post.read?
      end
    end
    posts.sort_by { |p| p.timestamp }.reverse
  end


  def refresh
    profiles.each do |profile|
      InitializeProfileJob.perform_later(profile.id)
    end
  end

  def new_profile(source, username)
    response = find_profile(username, source)
    new_profile = define_new_profile(response, source)
    if new_profile.save
      file = URI.open(new_profile.profile_pic)
      new_profile.photo.attach(io: file, filename: "#{new_profile.username}_profile.png", content_type: "image/png")
      InitializeProfileJob.perform_later(new_profile.id)
    end
  end

  private

  def find_profile(profile_name, source)
    case source
    when 'twitter'
      url = "https://twitter135.p.rapidapi.com/UserByScreenName/?username=#{profile_name}"
    when 'instagram'
      url = "https://instagram-data12.p.rapidapi.com/user/details-by-username/?username=#{profile_name}"
    end
    request_id_from_api(url)
  end

  def request_id_from_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    return JSON.parse(response.body)
  end


  def define_new_profile(response, source)
    case source
    when 'instagram'
      define_insta_profile(response)
    when 'twitter'
      define_twitter_profile(response)
    end
  end

  def define_insta_profile(response)
    user_data = response['data']['user']
    id = user_data['id']
    profile_pic_url = user_data['profile_pic_url_hd']
    username = user_data['username']
    new_profile = Profile.new(username: username, profile_source_id: id, profile_pic: profile_pic_url, profile_type: 'instagram')
    new_profile.list = self
    return new_profile
  end

  def define_twitter_profile(response)
    user_data = response['data']['user']['result']
    id = user_data['rest_id']
    profile_pic_url = user_data['legacy']['profile_image_url_https']
    username = user_data['legacy']['screen_name']
    new_profile = Profile.new(username: username, profile_source_id: id, profile_pic: profile_pic_url, profile_type: 'twitter')
    new_profile.list = self
    return new_profile
  end
end

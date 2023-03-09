require "open-uri"

class TwitterProfilesController < ApplicationController
  before_action :set_list, only: %i[new create]
  # def index
  #   @insta_profiles = current_user.list
  # end

  def new
    @twitter_profile = TwitterProfile.new
  end

  def create
    response = find_twitter_profile(twitter_profile_params[:username])
    return error_messages(response) unless call_succeeded?(response)

    new_twitter_profile = define_new_twitter_profile(response, @list)
    if new_twitter_profile.save
      file = URI.open(new_twitter_profile.profile_picture_url)
      new_twitter_profile.photo.attach(io: file, filename: "#{new_twitter_profile.username}_profile.png", content_type: "image/png")
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @twitter_profile = TwitterProfile.find(params[:id])
    @twitter_profile.destroy
    # redirect to where ??
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def twitter_profile_params
    params.require(:twitter_profile).permit(:username)
  end

  def define_new_twitter_profile(response, list)
    user_data = response['data']['user']['result']
    id = user_data['rest_id']
    profile_pic_url = user_data['legacy']['profile_image_url_https']
    username = user_data['legacy']['screen_name']
    new_twitter_profile = TwitterProfile.new(username: username, twitter_id: id, profile_picture_url: profile_pic_url)
    new_twitter_profile.list = list
    return new_twitter_profile
  end

  def request_twitter_id_from_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    return JSON.parse(response.body)
  end

  def find_twitter_profile(profile_name)
    request_twitter_id_from_api(
      "https://twitter135.p.rapidapi.com/UserByScreenName/?username=#{profile_name}"
    )
  end

  def call_succeeded?(response)
    errors = ['error', 'fail']
    return false if errors.include?(response['status'])

    true
  end

  def error_messages(response)
    error_message = response['message']
    @twitter_profile = TwitterProfile.new
    @twitter_profile.errors.add(:username, error_message)
    return render :new, status: :unprocessable_entity
  end
end

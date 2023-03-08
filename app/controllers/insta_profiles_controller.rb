require 'uri'
require 'net/http'
require 'openssl'

class InstaProfilesController < ApplicationController
  before_action :set_list, only: %i[new create]
  def index
    @insta_profiles = current_user.list
  end

  def new
    @insta_profile = InstaProfile.new
  end

  def create
    response = find_insta_profile(insta_profile_params[:username])
    return error_messages(response) unless call_succeeded?(response)

    new_insta_profile = define_new_insta_profile(response, @list)
    if new_insta_profile.save
      file = URI.open(new_insta_profile.profile_picture_url)
      new_insta_profile.photo.attach(io: file, filename: "#{new_insta_profile.username}_profile.png", content_type: "image/png")
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @insta_profile = InstaProfile.find(params[:id])
    @insta_profile.destroy
    # redirect to where ??
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def insta_profile_params
    params.require(:insta_profile).permit(:username)
  end

  def find_insta_profile(profile_name)
    request_insta_id_from_api(
      "https://instagram-data12.p.rapidapi.com/user/details-by-username/?username=#{profile_name}"
    )
  end

  def request_insta_id_from_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    return JSON.parse(response.body)
  end

  def call_succeeded?(response)
    errors = ['error', 'fail']
    return false if errors.include?(response['status'])

    true
  end

  def error_messages(response)
    error_message = response['message']
    @insta_profile = InstaProfile.new
    @insta_profile.errors.add(:username, error_message)
    return render :new, status: :unprocessable_entity
  end

  def define_new_insta_profile(response, list)
    user_data = response['data']['user']
    id = user_data['id']
    profile_pic_url = user_data['profile_pic_url_hd']
    username = user_data['username']
    new_insta_profile = InstaProfile.new(username: username, insta_id: id, profile_picture_url: profile_pic_url)
    new_insta_profile.list = list
    return new_insta_profile
  end
end

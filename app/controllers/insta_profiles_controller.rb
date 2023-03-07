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
    @user_data = find_insta_profile(insta_profile_params[:username])
    id = @user_data['id']
    profile_pic_url = @user_data['profile_pic_url_hd']
    username = @user_data['username']
    insta_profile = InstaProfile.new(username: username, insta_id: id, profile_picture_url: profile_pic_url)
    insta_profile.list = @list

    if insta_profile.save
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

  def request_insta_id_from_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    # return 'error' if response.status != 200

    parse_result = JSON.parse(response.body)
    @user_data = parse_result['data']['user']
  end

  def find_insta_profile(profile_name)
    request_insta_id_from_api(
      "https://instagram-data12.p.rapidapi.com/user/details-by-username/?username=#{profile_name}"
    )
  end
end

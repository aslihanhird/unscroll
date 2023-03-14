require 'open-uri'
require 'net/http'
require 'openssl'

class ProfilesController < ApplicationController
  before_action :set_list, only: %i[new create profile_added]

  def index
    @profiles = current_user.list
  end

  def new
    @profile = Profile.new
  end

  # def create
  #   source = params[:source] # NEED FRONT TO SEND THIS (added hidden tag param to forms)
  #   response = find_profile(profile_params[:username], source)
  #   return error_messages(response) unless call_succeeded?(response)
  #   new_profile = define_new_profile(response, @list, source)
  #   if new_profile.save
  #     file = URI.open(new_profile.profile_pic)
  #     new_profile.photo.attach(io: file, filename: "#{new_profile.username}_profile.png", content_type: "image/png")
  #     redirect_to list_profile_added_path(@list)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    source = params[:source]
    username = profile_params[:username]
    NewProfileJob.perform_later(source, username, @list)
    flash[:notice] = "Adding #{username} to your list..."
    redirect_to root_path
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to edit_list_path
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def profile_params
    params.require(:profile).permit(:username)
  end

  # def find_profile(profile_name, source)
  #   case source
  #   when 'twitter'
  #     url = "https://twitter135.p.rapidapi.com/UserByScreenName/?username=#{profile_name}"
  #   when 'instagram'
  #     url = "https://instagram-data12.p.rapidapi.com/user/details-by-username/?username=#{profile_name}"
  #   end
  #   request_id_from_api(url)
  # end

  # def request_id_from_api(url)
  #   response = Excon.get(
  #     url,
  #     headers: {
  #       'X-RapidAPI-Host' => URI.parse(url).host,
  #       'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
  #     }
  #   )
  #   return JSON.parse(response.body)
  # end

  # def call_succeeded?(response)
  #   errors = ['error', 'fail']
  #   return false if errors.include?(response['status'])

  #   true
  # end

  # def error_messages(response)
  #   error_message = response['message']
  #   @profile = Profile.new
  #   @profile.errors.add(:username, error_message)
  #   return render "pages/select_insta_or_twitter", status: :unprocessable_entity
  # end

  # def define_new_profile(response, list, source)
  #   case source
  #   when 'instagram'
  #     define_insta_profile(response, list)
  #   when 'twitter'
  #     define_twitter_profile(response, list)
  #   end
  # end

  # def define_insta_profile(response, list)
  #   user_data = response['data']['user']
  #   id = user_data['id']
  #   profile_pic_url = user_data['profile_pic_url_hd']
  #   username = user_data['username']
  #   new_profile = Profile.new(username: username, profile_source_id: id, profile_pic: profile_pic_url, profile_type: 'instagram')
  #   new_profile.list = list
  #   return new_profile
  # end

  # def define_twitter_profile(response, list)
  #   user_data = response['data']['user']['result']
  #   id = user_data['rest_id']
  #   profile_pic_url = user_data['legacy']['profile_image_url_https']
  #   username = user_data['legacy']['screen_name']
  #   new_profile = Profile.new(username: username, profile_source_id: id, profile_pic: profile_pic_url, profile_type: 'twitter')
  #   new_profile.list = list
  #   return new_profile
  # end
end

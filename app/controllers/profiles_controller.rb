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

  def create
    response = find_insta_profile(insta_profile_params[:username])
    return error_messages(response) unless call_succeeded?(response)

    new_insta_profile = define_new_insta_profile(response, @list)
    if new_insta_profile.save
      file = URI.open(new_insta_profile.profile_picture_url)
      new_insta_profile.photo.attach(io: file, filename: "#{new_insta_profile.username}_profile.png", content_type: "image/png")
      redirect_to list_profile_added_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @insta_profile = InstaProfile.find(params[:id])
    @insta_profile.destroy
    redirect_to edit_list_path
  end
end

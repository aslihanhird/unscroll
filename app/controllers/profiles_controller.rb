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
end

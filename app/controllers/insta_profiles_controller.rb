class InstaProfilesController < ApplicationController
  def new
    @insta_profile = InstaProfile.new
  end

  def create
    @insta_profile = InstaProfile.new(insta_profile_params)
    @insta_profile.save
  end

  def destroy
    @insta_profile = InstaProfile.find(params[:id])
    @insta_profile.destroy
    # redirect to where ??
  end

  private

  def insta_profile_params
    params.require(:insta_profile).permit(:username, :profile_picture_url, :insta_id )
  end
end

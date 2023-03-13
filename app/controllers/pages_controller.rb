class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to lists_path
  end

  def profile
    redirect_to root_path unless user_signed_in?
  end

  def select_insta_or_twitter
    @list = List.find(params[:list_id])
    @profile = Profile.new
  end

  def favourites
    @favourite_posts = current_user.fav_posts
  end
end

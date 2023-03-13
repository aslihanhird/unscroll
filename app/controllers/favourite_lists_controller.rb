class FavouriteListsController < ApplicationController
  def show
    favourite_list = current_user.favourite_list
    @favourite_posts = favourite_list.all_favourite_posts
  end
end

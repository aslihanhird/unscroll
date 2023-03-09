class FavouriteListsController < ApplicationController
  def show
    favourite_list = current_user.favourite_list
    @favourite_posts = favourite_list.all_favourite_posts
  end

  # def create
  #   favourite_list = FavouriteList.new(name: 'Favourites')
  #   favourite_list.user = current_user
  #   favourite_list.save
  # end
end
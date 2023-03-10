class FavouriteTwitterPostsController < ApplicationController
  def create
    puts "New FavouriteTwitterPost"
    og_twitter_post = TwitterPost.find(params[:twitter_post_id])
    checked_favourite_twitter_profile = check_favourite_profile(og_twitter_post)
    new_fav_twitter_post = FavouriteTwitterPost.new(caption: og_twitter_post.caption, timestamp: og_twitter_post.timestamp)
    new_fav_twitter_post.favourite_twitter_profile = checked_favourite_twitter_profile
    if og_twitter_post.photo.attached?
      new_fav_twitter_post.media_url = og_twitter_post.photo.key
    else
      new_fav_twitter_post.media_url = "none"
    end
    new_fav_twitter_post.save
  end

  def destroy
    favourite_twitter_post = FavouriteTwitterPost.find(params[:id])
    favourite_twitter_post.destroy
  end

  private

  def check_favourite_profile(og_twitter_post)
    checked_twitter_profile = FavouriteTwitterProfile.find_by(username: og_twitter_post.twitter_profile.username)
    return checked_twitter_profile if checked_twitter_profile != nil

    og_twitter_profile = TwitterProfile.find_by(username: og_twitter_post.twitter_profile.username)
    new_favourite_twitter_post = FavouriteTwitterProfile.new(username: og_twitter_profile.username)
    new_favourite_twitter_post.profile_picture_url = og_twitter_profile.photo.key
    new_favourite_twitter_post.favourite_list = current_user.favourite_list
    new_favourite_twitter_post.save
    new_favourite_twitter_post
  end
end

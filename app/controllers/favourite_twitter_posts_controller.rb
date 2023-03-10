class FavouriteTwitterPostsController < ApplicationController
end

def create
  og_twitter_post = TwitterPost.find(params[:twitter_post_id])
  checked_favourite_twitter_profile = check_favourite_profile(og_twitter_post)
  new_fav_twitter_post = FavouriteTwitterPost.new(caption: og_twitter_post.caption, timestamp: og_twitter_post.timestamp)
  new_fav_twitter_post.favourite_twitter_profile = checked_favourite_twitter_profile
  if og_twitter_post.video.attached?
    new_fav_twitter_post.media_url = og_twitter_post.video.key
    new_fav_twitter_post.media_type = 'video'
  elsif og_twitter_post.photo.attached?
    new_fav_twitter_post.media_url = og_twitter_post.photo.key
    new_fav_twitter_post.media_type = 'photo'
  else
    new_fav_twitter_post.media_url = ""
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
  new_favourite_twitter_post.favourite_list = FavouriteList.find_by(name: 'Favourites')
  new_favourite_twitter_post.save
  new_favourite_twitter_post
end

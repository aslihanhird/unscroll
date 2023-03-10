require "open-uri"

class FavouriteInstaPostsController < ApplicationController
  def create
    og_insta_post = InstaPost.find(params[:insta_post_id])
    checked_favourite_insta_profile = check_favourite_profile(og_insta_post)
    new_fav_insta_post = FavouriteInstaPost.new(caption: og_insta_post.caption, timestamp: og_insta_post.timestamp)
    new_fav_insta_post.favourite_insta_profile = checked_favourite_insta_profile
    if og_insta_post.video.attached?
      new_fav_insta_post.media_url = og_insta_post.video.key
      new_fav_insta_post.media_type = 'video'
    else
      new_fav_insta_post.media_url = og_insta_post.photo.key
      new_fav_insta_post.media_type = 'photo'
    end
    p "..................................."
    p new_fav_insta_post
    p ".................................."
    new_fav_insta_post.save
    p "..................................."
    p new_fav_insta_post
    p ".................................."
  end

  def destroy
    favourite_insta_post = FavouriteInstaPost.find(params[:id])
    favourite_insta_post.destroy
  end

  private

  def check_favourite_profile(og_insta_post)
    checked_insta_profile = FavouriteInstaProfile.find_by(username: og_insta_post.insta_profile.username)
    return checked_insta_profile if checked_insta_profile != nil

    og_insta_profile = InstaProfile.find_by(username: og_insta_post.insta_profile.username)
    new_favourite_insta_profile = FavouriteInstaProfile.new(username: og_insta_profile.username)
    new_favourite_insta_profile.profile_picture_url = og_insta_profile.photo.key
    new_favourite_insta_profile.favourite_list = FavouriteList.find_by(name: 'Favourites')
    new_favourite_insta_profile.save
    puts "/////////////////////////////////////////////////////////////"
    p new_favourite_insta_profile
    puts "Saved"
    puts "/////////////////////////////////////////////////////////////"
    new_favourite_insta_profile
  end
end

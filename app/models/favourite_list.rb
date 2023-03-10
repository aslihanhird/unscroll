class FavouriteList < ApplicationRecord
  belongs_to :user

  has_many :favourite_insta_profiles, dependent: :destroy
  has_many :favourite_insta_posts, through: :favourite_insta_profiles, dependent: :destroy

  validates :name, presence: true

  def all_favourite_posts
    posts = []
    favourite_insta_profiles.each do |insta|
      insta.favourite_insta_posts.each do |post|
        posts.push(post)
      end
    end
    favourite_twitter_profiles.each do |twit|
      twit.favourite_twitter_posts.each do |post|
        posts.push(post)
      end
    end
    posts.sort_by { |p| p.timestamp.to_i }.reverse
  end
end

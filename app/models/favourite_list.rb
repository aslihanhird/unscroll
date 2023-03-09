class FavouriteList < ApplicationRecord
  belongs_to :user

  has_many :favourite_insta_profiles
  has_many :favourite_insta_posts, through: :insta_profiles

  validates :name, presence: true

  def all_favourite_posts
    posts = []
    self.favourite_insta_profiles.each do |insta|
      insta.favourite_insta_posts.each do |post|
        posts.push(post)
      end
    end
    posts.sort_by { |p| p.timestamp.to_i }.reverse
  end
end

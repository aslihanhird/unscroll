class List < ApplicationRecord
  belongs_to :user

  has_many :profiles
  has_many :insta_profiles, dependent: :destroy
  has_many :twitter_profiles, dependent: :destroy

  has_many :posts, through: :profiles

  validates :name, presence: true

  def all_posts
    posts = []
    insta_profiles.each do |insta|
      insta.insta_posts.each do |post|
        posts.push(post)
      end
    end
    twitter_profiles.each do |twit|
      twit.twitter_posts.each do |post|
        posts.push(post)
      end
    end
    posts.sort_by { |p| p.timestamp.to_i }.reverse
  end
end

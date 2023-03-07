class List < ApplicationRecord
  belongs_to :user

  has_many :insta_profiles
  has_many :insta_posts, through: :insta_profiles

  validates :name, presence: true

  def all_posts
    posts = []
    self.insta_profiles.each do |insta|
      insta.insta_posts.each do |post|
        posts.push(post)
      end
    end
    posts
  end
end

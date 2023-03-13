class List < ApplicationRecord
  belongs_to :user

  has_many :profiles

  has_many :posts, through: :profiles

  validates :name, presence: true

  def all_posts
    posts = []
    profiles.each do |profile|
      profile.posts.each do |post|
        posts.push(post)
      end
    end
    posts.sort_by { |p| p.timestamp }.reverse
  end
end

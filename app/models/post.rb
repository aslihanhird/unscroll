class Post < ApplicationRecord
  belongs_to :profile

  has_many_attached :photos
  has_many_attached :videos

  def self.unread_all
    posts = Post.all

    posts.each do |post|
      post.read = false
      post.save
    end

  end
end

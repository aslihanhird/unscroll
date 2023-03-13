class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lists, dependent: :destroy
  has_many :profiles, through: :lists, dependent: :destroy

  def fav_posts
    fav_posts = []
    self.lists.each do |list|
      list.posts.where(favourite: true).each do |post|
        fav_posts << post
      end
    end
    fav_posts
  end
end

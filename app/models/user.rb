class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_favourites

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lists, dependent: :destroy
  has_many :profiles, through: :lists, dependent: :destroy

  def fav_posts
    fav_posts = []
    self.lists.each do |list|
      fav_posts << list.posts.where(favourite: true)
    end
    fav_posts
  end
end

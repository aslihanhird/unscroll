class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_favourites

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lists, dependent: :destroy
  has_many :insta_profiles, through: :lists
  has_one :favourite_list

  private

  def create_favourites
    FavouriteList.new(name: "Favourites", user: self)
  end
end

class FavouriteInstaProfile < ApplicationRecord
  belongs_to :favourite_list

  has_many :favourite_insta_posts
  has_one_attached :photo

  validates :username, presence: true
end

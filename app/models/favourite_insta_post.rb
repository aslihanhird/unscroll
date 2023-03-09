class FavouriteInstaPost < ApplicationRecord
  belongs_to :favourite_insta_profile
  
  has_one_attached :photo
  has_one_attached :video
end

class FavouriteTwitterProfile < ApplicationRecord
  belongs_to :favourite_list

  has_many :favourite_twitter_posts, dependent: :destroy
end

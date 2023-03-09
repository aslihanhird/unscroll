class TwitterPost < ApplicationRecord
  belongs_to :twitter_profile
  has_one_attached :photo
  has_one_attached :video
end

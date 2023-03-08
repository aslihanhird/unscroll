class InstaPost < ApplicationRecord
  belongs_to :insta_profile
  has_one_attached :photo
  has_one_attached :video
end

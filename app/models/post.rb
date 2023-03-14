class Post < ApplicationRecord
  belongs_to :profile

  has_many_attached :photos
  has_many_attached :videos
end

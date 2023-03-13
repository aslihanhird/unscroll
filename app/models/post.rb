class Post < ApplicationRecord
  belongs_to :profile

  has_many_attached :photo
  has_many_attached :video
end

class List < ApplicationRecord
  belongs_to :user
  has_many :insta_profiles
  has_many :posts, through: :insta_profiles
end

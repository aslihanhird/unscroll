class List < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :insta_profiles
  has_many :insta_posts, through: :insta_profiles
end

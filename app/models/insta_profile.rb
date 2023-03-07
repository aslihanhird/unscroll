class InstaProfile < ApplicationRecord
  belongs_to :list, dependent: :destroy
  has_many :insta_posts
end

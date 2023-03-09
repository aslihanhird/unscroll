class TwitterProfile < ApplicationRecord
  belongs_to :list

  has_many :twitter_posts, dependent: :destroy
  has_one_attached :photo

  validates :username, presence: true
end

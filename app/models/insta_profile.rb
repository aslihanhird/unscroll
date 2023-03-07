class InstaProfile < ApplicationRecord
  belongs_to :list

  has_many :insta_posts, dependent: :destroy

  validates :username, presence: true
end

class Profile < ApplicationRecord
  belongs_to :list

  has_many :posts
  has_one_attached :photo

  validates :username, presence: true
end

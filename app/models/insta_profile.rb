class InstaProfile < ApplicationRecord
  belongs_to :list, dependent: :destroy
  haas_many :posts
end

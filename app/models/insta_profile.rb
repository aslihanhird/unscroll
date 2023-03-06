class InstaProfile < ApplicationRecord
  belongs_to :list
  haas_many :posts
end

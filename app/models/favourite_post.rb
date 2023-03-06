class FavouritePost < ApplicationRecord
  belongs_to :user, dependent: :destroy
end

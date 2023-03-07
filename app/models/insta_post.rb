class InstaPost < ApplicationRecord
  belongs_to :insta_profile, dependent: :destroy
  
end

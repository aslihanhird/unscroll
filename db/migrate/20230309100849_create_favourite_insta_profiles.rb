class CreateFavouriteInstaProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_insta_profiles do |t|
      t.string :username
      t.string :profile_picture_url
      t.references :favourite_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end

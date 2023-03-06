class CreateFavouritePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_posts do |t|
      t.string :username
      t.string :profile_picture_url
      t.string :caption
      t.string :media_url
      t.string :timestamp
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class AddMediaTypeToFavouriteInstaPost < ActiveRecord::Migration[7.0]
  def change
    add_column :favourite_insta_posts, :media_type, :string
  end
end

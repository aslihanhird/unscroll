class AddCategoryToFavouriteInstaPost < ActiveRecord::Migration[7.0]
  def change
    add_column :favourite_insta_posts, :category, :string
  end
end

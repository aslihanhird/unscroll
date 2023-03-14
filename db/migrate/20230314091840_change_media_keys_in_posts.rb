class ChangeMediaKeysInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :media_keys, :string, array: true
  end
end

class CreateTwitterPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :twitter_posts do |t|
      t.string :caption
      t.string :media_url
      t.string :timestamp
      t.references :twitter_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :caption
      t.string :media_url
      t.integer :timestamp
      t.string :source
      t.string :media_type
      t.boolean :favourite
      t.boolean :read
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

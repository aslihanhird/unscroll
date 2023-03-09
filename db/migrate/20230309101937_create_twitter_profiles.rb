class CreateTwitterProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :twitter_profiles do |t|
      t.string :username
      t.string :profile_picture_url
      t.string :twitter_id
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end

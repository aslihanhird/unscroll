class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :profile_type
      t.string :profile_pic
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end

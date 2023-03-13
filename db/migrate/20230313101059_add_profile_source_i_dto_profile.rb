class AddProfileSourceIDtoProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :profile_source_id, :string
  end
end

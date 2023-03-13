class AddDefaultValuesToPostBooleans < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :favourite, :boolean,  null: false, default: false
    change_column :posts, :read, :boolean, null: false, default: false
  end
end

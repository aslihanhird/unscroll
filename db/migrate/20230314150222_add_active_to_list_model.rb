class AddActiveToListModel < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :active, :boolean, default: true, null: false
  end
end

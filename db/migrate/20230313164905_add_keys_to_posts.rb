class AddKeysToPosts < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    add_column :posts, :media_keys, :hstore, array: true
  end
end

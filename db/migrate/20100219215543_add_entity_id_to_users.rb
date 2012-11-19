class AddEntityIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :entity_id, :integer
  end

  def self.down
    remove_column :users, :entity_id
  end
end

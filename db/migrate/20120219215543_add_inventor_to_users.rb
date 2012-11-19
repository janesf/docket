class AddInventorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :inventor, :boolean
  end

  def self.down
    remove_column :users, :inventor
  end
end

class AddDescriptionAndAccessToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :description, :string
    add_column :roles, :data_read, :boolean
    add_column :roles, :data_write, :boolean
    add_column :roles, :system_readwrite, :boolean
  end

  def self.down
    remove_column :roles, :description
    remove_column :roles, :data_read
    remove_column :roles, :data_write
    remove_column :roles, :system_readwrite
  end
end

class AddIandpIdToInventorships < ActiveRecord::Migration
  def self.up
    add_column :inventorships, :inventor_id, :integer
    add_column :inventorships, :patentcase_id, :integer
  end

  def self.down
    remove_column :inventorships, :patentcase_id
    remove_column :inventorships, :inventor_id
  end
end

class AddEntityIdToPatentcase < ActiveRecord::Migration
  def self.up
    add_column :patentcases, :entity_id, :integer
  end

  def self.down
    remove_column :patentcases, :entity_id
  end
end

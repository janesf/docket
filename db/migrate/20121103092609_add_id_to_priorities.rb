class AddIdToPriorities < ActiveRecord::Migration
  def self.up
    add_column :priorities, :id, :integer
  end

  def self.down
    remove_column :priorities, :id
  end
end

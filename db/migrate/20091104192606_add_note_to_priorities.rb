class AddNoteToPriorities < ActiveRecord::Migration
  def self.up
    add_column :priorities, :note, :text
  end

  def self.down
    remove_column :priorities, :note
  end
end

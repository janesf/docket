class RemoveKeyFromPriorities < ActiveRecord::Migration
  def change
    remove_column :priorities, :id
  end
end

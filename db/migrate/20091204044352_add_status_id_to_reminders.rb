class AddStatusIdToReminders < ActiveRecord::Migration
  def self.up
    add_column :reminders, :rstatus_id, :integer
    add_column :reminders, :type_id, :integer
    add_column :reminders, :event_id, :integer
    add_column :reminders, :refdttype_id, :integer
    add_column :reminders, :applytowatch, :boolean
    add_column :reminders, :rmdroffset, :integer
    add_column :reminders, :action_id, :integer
  end

  def self.down
    remove_column :reminders, :action_id
    remove_column :reminders, :rmdroffset
    remove_column :reminders, :applytowatch
    remove_column :reminders, :refdttype_id
    remove_column :reminders, :event_id
    remove_column :reminders, :type_id
    remove_column :reminders, :rstatus_id
  end
end

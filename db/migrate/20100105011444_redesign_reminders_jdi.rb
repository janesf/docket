class RedesignRemindersJdi < ActiveRecord::Migration
  def self.up
    add_column :reminders, :completed, :boolean
    add_column :reminders, :completing_action, :integer
    add_column :reminders, :date_completed, :date
    add_column :reminders, :dismissed, :boolean
    add_column :reminders, :dismissed_by, :integer
    add_column :reminders, :date_dismissed, :date
    remove_column :reminders, :rmdroffset
    remove_column :reminders, :applytowatch
    remove_column :reminders, :refdttype_id
    remove_column :reminders, :event_id
    remove_column :reminders, :type_id
  end

  def self.down
    remove_column :reminders, :completed
    remove_column :reminders, :completing_action
    remove_column :reminders, :date_completed
    remove_column :reminders, :dismissed
    remove_column :reminders, :dismissed_by
    remove_column :reminders, :date_dismissed
    add_column :reminders, :rmdroffset, :integer
    add_column :reminders, :applytowatch, :boolean
    add_column :reminders, :refdttype_id, :integer
    add_column :reminders, :event_id, :integer
    add_column :reminders, :type_id, :integer
  end
end

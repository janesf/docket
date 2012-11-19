class AddDueDateToReminders < ActiveRecord::Migration
  def self.up
    add_column :reminders, :due_date, :date
  end

  def self.down
    remove_column :reminders, :due_date
  end
end

class FixReminderAactionAndRulePointers < ActiveRecord::Migration
  def self.up
    rename_column :reminders, :action_id, :aaction_id
    add_column :reminders, :rule_id, :integer
  end

  def self.down
    remove_column :reminders, :rule_id
    rename_column :reminders, :aaction_id, :action_id
  end
end

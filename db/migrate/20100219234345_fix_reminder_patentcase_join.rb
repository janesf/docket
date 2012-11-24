class FixReminderPatentcaseJoin < ActiveRecord::Migration
  def self.up
    change_column :reminders, :case_id, :integer
    rename_column :reminders, :case_id, :patentcase_id
  end

  def self.down
    rename_column :reminders, :patentcase_id, :case_id
    change_column :reminders, :case_id, :string
  end
end

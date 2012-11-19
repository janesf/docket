class FixReminderPatentcaseJoin < ActiveRecord::Migration
  def self.up
    rename_column :reminders, :case_id, :patentcase_id
    change_column :reminders, :patentcase_id, :integer
  end

  def self.down
    change_column :reminders, :patentcase_id, :string
    rename_column :reminders, :patentcase_id, :case_id
  end
end

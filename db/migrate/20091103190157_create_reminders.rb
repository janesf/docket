class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.date :dtrmdr
      t.integer :patentcase_id
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end

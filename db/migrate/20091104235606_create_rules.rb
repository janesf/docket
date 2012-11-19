class CreateRules < ActiveRecord::Migration
  def self.up
    create_table :rules do |t|
      t.integer :rule_id
      t.text :tdesc
      t.text :reminder
      t.date :rmdroffset
      t.integer :type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rules
  end
end

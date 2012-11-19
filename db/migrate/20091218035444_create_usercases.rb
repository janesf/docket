class CreateUsercases < ActiveRecord::Migration
  def self.up
    create_table :usercases do |t|
      t.integer :user_id
      t.integer :patentcase_id

      t.timestamps
    end
  end

  def self.down
    drop_table :usercases
  end
end

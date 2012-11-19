class CreatePatentcasesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :patentcases_users, :id => false do |t|
      t.integer :patentcase_id
      t.integer :user_id
    end
    add_index :patentcases_users, [:patentcase_id, :user_id], :unique => true
  end

  def self.down
    drop_table :patentcases_users
  end
end

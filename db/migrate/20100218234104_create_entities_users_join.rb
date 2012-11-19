class CreateEntitiesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :entities_users, :id => false do |t|
      t.integer :entity_id
      t.integer :user_id
    end
    add_index :entities_users, [:entity_id, :user_id], :unique => true
  end

  def self.down
    drop_table :entities_users
  end
end

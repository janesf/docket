class CreateInventorships < ActiveRecord::Migration
  def self.up
    create_table :inventorships do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :inventorships
  end
end

class CreateEntityAccesses < ActiveRecord::Migration
  def self.up
    create_table :entity_accesses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :entity_accesses
  end
end

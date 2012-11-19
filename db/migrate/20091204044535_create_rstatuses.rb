class CreateRstatuses < ActiveRecord::Migration
  def self.up
    create_table :rstatuses do |t|
      t.string :name
      t.integer :statuscd

      t.timestamps
    end
  end

  def self.down
    drop_table :rstatuses
  end
end

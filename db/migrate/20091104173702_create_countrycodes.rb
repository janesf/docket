class CreateCountrycodes < ActiveRecord::Migration
  def self.up
    create_table :countrycodes do |t|
      t.integer :id
      t.string :ccode
      t.string :cname

      t.timestamps
    end
  end

  def self.down
    drop_table :countrycodes
  end
end

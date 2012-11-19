class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.integer :type_id
      t.string :desc
      t.boolean :final

      t.timestamps
    end
  end

  def self.down
    drop_table :types
  end
end

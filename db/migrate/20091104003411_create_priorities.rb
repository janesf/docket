class CreatePriorities < ActiveRecord::Migration
  def self.up
    create_table :priorities do |t|
      t.integer :parent_id
      t.integer :child_id
      t.text    :note
      t.watch   :boolean
      t.priority :boolean
      t.timestamps
    end
  end

  def self.down
    drop_table :priorities
  end
end

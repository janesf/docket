class CreateEntities < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.string :name
      t.integer :entitytype_id
      t.string :jurisdiction
      t.string :addr1
      t.string :addr2
      t.string :city
      t.string :st
      t.integer :zip
      t.string :country
      t.string :mainphone
      t.string :main
      t.string :contactname
      t.string :contactphone
      t.string :contactfax
      t.string :contactemail
      t.boolean :small

      t.timestamps
    end
  end

  def self.down
    drop_table :entities
  end
end

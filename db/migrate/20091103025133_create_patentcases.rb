class CreatePatentcases < ActiveRecord::Migration
  def self.up
    create_table :patentcases do |t|
      t.integer :applicationnumber
      t.string :title
      t.string :jurisdiction
      t.string :owner
      t.date :filingdate
      t.integer :patentnumber
      t.string :docket
      t.string :responsible
      t.boolean :reqNonPub
      t.boolean :published
      t.integer :publicationNo
      t.string :techcenter
      t.string :examiner
      t.integer :Conf_no
      t.boolean :small
      t.date :forFilingLicense

      t.timestamps
    end
  end

  def self.down
    drop_table :patentcases
  end
end

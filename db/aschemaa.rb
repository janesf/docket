# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120828054830) do

  create_table "countrycodes", :force => true do |t|
    t.string   "ccode"
    t.string   "cname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "jurisdiction"
    t.string   "addr1"
    t.string   "addr2"
    t.string   "city"
    t.string   "st"
    t.integer  "zip"
    t.string   "country"
    t.string   "mainphone"
    t.string   "main"
    t.string   "contactname"
    t.string   "contactphone"
    t.string   "contactfax"
    t.string   "contactemail"
    t.boolean  "small"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities_users", :id => false, :force => true do |t|
    t.integer "entity_id"
    t.integer "user_id"
  end

  add_index "entities_users", ["entity_id", "user_id"], :name => "index_entities_users_on_entity_id_and_user_id", :unique => true

  create_table "entity_accesses", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventors", :force => true do |t|
    t.integer  "inventor_id"
    t.integer  "entity_id"
    t.string   "address"
    t.string   "state"
    t.string   "country"
    t.string   "citizenship"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first"
    t.string   "middle"
    t.string   "last"
  end

  create_table "inventorships", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "inventor_id"
    t.integer  "patentcase_id"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "rating"
    t.text     "description"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patentcases", :force => true do |t|
    t.integer  "applicationnumber"
    t.string   "title"
    t.string   "jurisdiction"
    t.string   "owner"
    t.date     "filingdate"
    t.integer  "patentnumber"
    t.string   "responsible"
    t.boolean  "reqNonPub"
    t.boolean  "published"
    t.integer  "publicationNo"
    t.string   "techcenter"
    t.string   "examiner"
    t.integer  "Conf_no"
    t.boolean  "small"
    t.date     "forFilingLicense"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.string   "attorneydocket"
  end

  create_table "patentcases_users", :id => false, :force => true do |t|
    t.integer "patentcase_id"
    t.integer "user_id"
  end

  add_index "patentcases_users", ["patentcase_id", "user_id"], :name => "index_patentcases_users_on_patentcase_id_and_user_id", :unique => true

  create_table "priorities", :id => false, :force => true do |t|
    t.integer  "parent_id"
    t.integer  "childid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "reminders", :force => true do |t|
    t.date     "dtrmdr"
    t.integer  "patentcase_id",     :limit => 255
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rstatus_id"
    t.integer  "aaction_id"
    t.date     "due_date"
    t.boolean  "completed"
    t.integer  "completing_action"
    t.date     "date_completed"
    t.boolean  "dismissed"
    t.integer  "dismissed_by"
    t.date     "date_dismissed"
    t.integer  "rule_id"
  end

  create_table "roles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.boolean  "data_read"
    t.boolean  "data_write"
    t.boolean  "system_readwrite"
  end

  create_table "rstatuses", :force => true do |t|
    t.string   "name"
    t.integer  "statuscd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", :force => true do |t|
    t.integer  "rule_id"
    t.text     "tdesc"
    t.text     "reminder"
    t.date     "rmdroffset"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", :force => true do |t|
    t.integer  "type_id"
    t.string   "desc"
    t.boolean  "final"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_reminders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reminder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usercases", :force => true do |t|
    t.integer  "user_id"
    t.integer  "patentcase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "entity_id"
    t.boolean  "admin"
    t.integer  "role_id"
  end

end

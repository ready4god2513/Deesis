# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100412043337) do

  create_table "comments", :force => true do |t|
    t.integer  "prayer_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prayers", :force => true do |t|
    t.integer  "user_id"
    t.text     "prayer"
    t.integer  "num_responses"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "answered",      :default => false
    t.boolean  "private",       :default => false
  end

  create_table "reminders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "prayer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "location"
    t.integer  "postal_code"
    t.string   "email"
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "api_key"
    t.string   "pic"
    t.integer  "login_count"
    t.datetime "last_login_at"
    t.datetime "last_request_at"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.string   "activity_stream_token"
    t.string   "perishable_token",         :default => "",   :null => false
    t.boolean  "remind_me",                :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end

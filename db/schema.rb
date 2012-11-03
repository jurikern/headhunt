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

ActiveRecord::Schema.define(:version => 20121103214503) do

  create_table "companies", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.string   "title",      :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",       :default => 0,  :null => false
    t.string   "full_name",     :default => "", :null => false
    t.date     "date_of_birth"
    t.string   "email",         :default => "", :null => false
    t.string   "phone",         :default => "", :null => false
    t.string   "skype",         :default => "", :null => false
    t.string   "country",       :default => "", :null => false
    t.string   "country_code",  :default => "", :null => false
    t.string   "state",         :default => "", :null => false
    t.string   "state_code",    :default => "", :null => false
    t.string   "city",          :default => "", :null => false
    t.string   "address",       :default => "", :null => false
    t.text     "description",   :default => "", :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "providers", :force => true do |t|
    t.integer  "user_id",    :default => 0,  :null => false
    t.string   "name",       :default => "", :null => false
    t.string   "uid",        :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "providers", ["name", "uid"], :name => "index_providers_on_name_and_uid", :unique => true

  create_table "redactor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "password_salt",          :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  add_foreign_key "profiles", "users", :name => "profiles_user_id_fk", :dependent => :delete

  add_foreign_key "providers", "users", :name => "providers_user_id_fk", :dependent => :delete

end

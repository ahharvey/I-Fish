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

ActiveRecord::Schema.define(:version => 20121202170024) do


  create_table "catches", :force => true do |t|
    t.integer  "fish_id"
    t.integer  "landing_id"
    t.integer  "length"
    t.integer  "weight"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "desas", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "excel_files", :force => true do |t|
    t.string   "filename"
    t.string   "filesize"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "fisheries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fishes", :force => true do |t|
    t.string   "order"
    t.string   "family"
    t.string   "scientific_name"
    t.string   "fishbase_name"
    t.string   "english_name"
    t.string   "indonesia_name"
    t.string   "code"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "gears", :force => true do |t|
    t.string   "cat_ind"
    t.string   "cat_eng"
    t.string   "sub_cat_ind"
    t.string   "sub_cat_eng"
    t.string   "type_ind"
    t.string   "type_eng"
    t.string   "name"
    t.string   "alpha_code"
    t.string   "num_code"
    t.string   "fao_code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "landings", :force => true do |t|
    t.string   "power"
    t.string   "fishing_area"
    t.string   "vessel_ref"
    t.string   "vessel_name"
    t.string   "grid_square"
    t.string   "engine"
    t.string   "fuel"
    t.string   "sail"
    t.string   "crew"
    t.string   "value"
    t.integer  "boat_size"
    t.integer  "gear_id"
    t.integer  "survey_id"
    t.integer  "quantity"
    t.integer  "weight"
    t.datetime "time_out"
    t.datetime "time_in"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "type"
  end

  create_table "surveys", :force => true do |t|
    t.date     "date_published"
    t.integer  "user_id"
    t.integer  "desa_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "fishery_id"
    t.string   "fleet_observer"
    t.string   "catch_scribe"
    t.string   "catch_measure"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end

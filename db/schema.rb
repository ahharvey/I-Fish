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

ActiveRecord::Schema.define(:version => 20131031045202) do

  create_table "activities", :force => true do |t|
    t.string   "action"
    t.integer  "ownable_id"
    t.string   "ownable_type"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["ownable_id"], :name => "index_activities_on_ownable_id"
  add_index "activities", ["trackable_id"], :name => "index_activities_on_trackable_id"

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "god_mode",               :default => false
    t.boolean  "reports_only",           :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.integer  "office_id"
    t.string   "avatar"
    t.boolean  "approved",               :default => false, :null => false
  end

  add_index "admins", ["approved"], :name => "index_admins_on_approved"
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "admins_roles", :id => false, :force => true do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], :name => "by_admin_and_role", :unique => true

  create_table "catches", :force => true do |t|
    t.integer  "fish_id"
    t.integer  "landing_id"
    t.integer  "length"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "sfactor"
    t.integer  "row"
  end

  create_table "desas", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.float    "lat"
    t.float    "lng"
    t.integer  "district_id"
  end

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "province_id"
    t.integer  "code"
  end

  create_table "engines", :force => true do |t|
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
    t.integer  "admin_id"
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
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "a"
    t.integer  "b"
    t.integer  "mat"
    t.integer  "max"
    t.integer  "opt"
    t.boolean  "threatened",      :default => false
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

  create_table "graticules", :force => true do |t|
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "landings", :force => true do |t|
    t.string   "vessel_ref"
    t.string   "vessel_name"
    t.integer  "boat_size"
    t.integer  "gear_id"
    t.integer  "survey_id"
    t.integer  "quantity"
    t.integer  "weight"
    t.datetime "time_out"
    t.datetime "time_in"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "type"
    t.integer  "engine_id"
    t.integer  "graticule_id"
    t.integer  "fish_id"
    t.integer  "cpue"
    t.integer  "value"
    t.integer  "cpue_kg"
    t.integer  "cpue_idr"
    t.integer  "cpue_fuel"
    t.boolean  "sail"
    t.integer  "fuel"
    t.integer  "power"
    t.integer  "crew"
    t.integer  "row"
    t.integer  "vessel_type_id"
    t.integer  "ice"
    t.integer  "conditions"
    t.string   "aborted"
  end

  add_index "landings", ["fish_id"], :name => "index_landings_on_fish_id"
  add_index "landings", ["vessel_type_id"], :name => "index_landings_on_vessel_type_id"

  create_table "logbooks", :force => true do |t|
    t.date     "date"
    t.integer  "admin_id"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "fishery_id"
    t.integer  "approver_id"
    t.boolean  "approved",    :default => false, :null => false
  end

  add_index "logbooks", ["admin_id"], :name => "index_logbooks_on_admin_id"
  add_index "logbooks", ["approved"], :name => "index_logbooks_on_approved"
  add_index "logbooks", ["approver_id"], :name => "index_logbooks_on_approver_id"
  add_index "logbooks", ["fishery_id"], :name => "index_logbooks_on_fishery_id"
  add_index "logbooks", ["user_id"], :name => "index_logbooks_on_user_id"

  create_table "logged_days", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "gear_time"
    t.integer  "fuel"
    t.boolean  "sail"
    t.boolean  "net"
    t.boolean  "line"
    t.integer  "quantity"
    t.integer  "weight"
    t.integer  "value"
    t.integer  "condition"
    t.integer  "moon"
    t.integer  "fish_id"
    t.integer  "graticule_id"
    t.integer  "logbook_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "crew"
    t.boolean  "aborted"
    t.integer  "ice"
  end

  add_index "logged_days", ["fish_id"], :name => "index_logged_days_on_fish_id"
  add_index "logged_days", ["graticule_id"], :name => "index_logged_days_on_graticule_id"
  add_index "logged_days", ["logbook_id"], :name => "index_logged_days_on_logbook_id"

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "district_id"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "alpha_code"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["user_id", "role_id"], :name => "by_user_and_role", :unique => true

  create_table "surveys", :force => true do |t|
    t.date     "date_published"
    t.integer  "desa_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "fishery_id"
    t.integer  "admin_id"
    t.boolean  "approved",              :default => false, :null => false
    t.integer  "approver_id"
    t.integer  "landing_enumerator_id"
    t.integer  "catch_measurer_id"
    t.integer  "catch_scribe_id"
  end

  add_index "surveys", ["approved"], :name => "index_surveys_on_approved"
  add_index "surveys", ["approver_id"], :name => "index_surveys_on_approver_id"
  add_index "surveys", ["catch_measurer_id"], :name => "index_surveys_on_catch_measurer_id"
  add_index "surveys", ["catch_scribe_id"], :name => "index_surveys_on_catch_scribe_id"
  add_index "surveys", ["landing_enumerator_id"], :name => "index_surveys_on_landing_enumerator_id"

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
    t.integer  "desa_id"
    t.string   "avatar"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "vessel_types", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

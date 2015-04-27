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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150408235611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "action",         limit: 255
    t.integer  "ownable_id"
    t.string   "ownable_type",   limit: 255
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "activities", ["ownable_id"], name: "index_activities_on_ownable_id", using: :btree
  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "god_mode",                           default: false
    t.boolean  "reports_only",                       default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "name",                   limit: 255
    t.integer  "office_id"
    t.string   "avatar",                 limit: 255
    t.boolean  "approved",                           default: false, null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                  default: 0
  end

  add_index "admins", ["approved"], name: "index_admins_on_approved", using: :btree
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["invitation_token"], name: "index_admins_on_invitation_token", unique: true, using: :btree
  add_index "admins", ["invitations_count"], name: "index_admins_on_invitations_count", using: :btree
  add_index "admins", ["invited_by_id"], name: "index_admins_on_invited_by_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_roles", id: false, force: :cascade do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "by_admin_and_role", unique: true, using: :btree

  create_table "bait_loadings", force: :cascade do |t|
    t.date     "date"
    t.integer  "vessel_id"
    t.string   "location"
    t.integer  "fish_id"
    t.integer  "quantity"
    t.integer  "unloading_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "price"
    t.string   "method_type"
    t.string   "review_state", default: "pending"
  end

  add_index "bait_loadings", ["fish_id"], name: "index_bait_loadings_on_fish_id", using: :btree
  add_index "bait_loadings", ["unloading_id"], name: "index_bait_loadings_on_unloading_id", using: :btree
  add_index "bait_loadings", ["vessel_id"], name: "index_bait_loadings_on_vessel_id", using: :btree

  create_table "carrier_loadings", force: :cascade do |t|
    t.date    "date"
    t.integer "vessel_id"
    t.integer "fish_id"
    t.string  "location"
    t.string  "size"
    t.string  "grade"
    t.integer "quantity"
    t.string  "review_state", default: "pending"
    t.string  "string",       default: "pending"
  end

  add_index "carrier_loadings", ["fish_id"], name: "index_carrier_loadings_on_fish_id", using: :btree
  add_index "carrier_loadings", ["vessel_id"], name: "index_carrier_loadings_on_vessel_id", using: :btree

  create_table "catches", force: :cascade do |t|
    t.integer  "fish_id"
    t.integer  "landing_id"
    t.integer  "length"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "sfactor",     limit: 255
    t.integer  "row"
    t.string   "measurement", limit: 255
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.boolean  "shark_policy"
    t.boolean  "iuu_list"
    t.boolean  "code_of_conduct"
    t.boolean  "member"
    t.string   "avatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "code"
  end

  create_table "desas", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.float    "lat"
    t.float    "lng"
    t.integer  "district_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "province_id"
    t.integer  "code"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "file"
    t.string   "content_type"
    t.string   "file_size"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "engines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "excel_files", force: :cascade do |t|
    t.string   "filename",   limit: 255
    t.string   "filesize",   limit: 255
    t.string   "file",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "admin_id"
  end

  create_table "fisheries", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "protocol_id"
  end

  create_table "fisheries_companies", id: false, force: :cascade do |t|
    t.integer "fishery_id"
    t.integer "company_id"
  end

  create_table "fisheries_fishes", id: false, force: :cascade do |t|
    t.integer "fishery_id"
    t.integer "fish_id"
  end

  create_table "fisheries_gears", id: false, force: :cascade do |t|
    t.integer "fishery_id"
    t.integer "gear_id"
  end

  create_table "fisheries_offices", id: false, force: :cascade do |t|
    t.integer "fishery_id"
    t.integer "office_id"
  end

  create_table "fishes", force: :cascade do |t|
    t.string   "order",           limit: 255
    t.string   "family",          limit: 255
    t.string   "scientific_name", limit: 255
    t.string   "fishbase_name",   limit: 255
    t.string   "english_name",    limit: 255
    t.string   "indonesia_name",  limit: 255
    t.string   "code",            limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "a"
    t.integer  "b"
    t.integer  "mat"
    t.integer  "max"
    t.integer  "opt"
    t.boolean  "threatened",                  default: false
  end

  create_table "gears", force: :cascade do |t|
    t.string   "cat_ind",     limit: 255
    t.string   "cat_eng",     limit: 255
    t.string   "sub_cat_ind", limit: 255
    t.string   "sub_cat_eng", limit: 255
    t.string   "type_ind",    limit: 255
    t.string   "type_eng",    limit: 255
    t.string   "name",        limit: 255
    t.string   "alpha_code",  limit: 255
    t.string   "num_code",    limit: 255
    t.string   "fao_code",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "graticules", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "landings", force: :cascade do |t|
    t.string   "vessel_ref",     limit: 255
    t.string   "vessel_name",    limit: 255
    t.integer  "boat_size"
    t.integer  "gear_id"
    t.integer  "survey_id"
    t.integer  "quantity"
    t.integer  "weight"
    t.datetime "time_out"
    t.datetime "time_in"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "type",           limit: 255
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
    t.string   "aborted",        limit: 255
  end

  add_index "landings", ["fish_id"], name: "index_landings_on_fish_id", using: :btree
  add_index "landings", ["vessel_type_id"], name: "index_landings_on_vessel_type_id", using: :btree

  create_table "logbooks", force: :cascade do |t|
    t.date     "date"
    t.integer  "admin_id"
    t.integer  "user_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "fishery_id"
    t.integer  "reviewer_id"
    t.string   "review_state", limit: 255, default: "pending"
    t.datetime "reviewed_at"
  end

  add_index "logbooks", ["admin_id"], name: "index_logbooks_on_admin_id", using: :btree
  add_index "logbooks", ["fishery_id"], name: "index_logbooks_on_fishery_id", using: :btree
  add_index "logbooks", ["reviewer_id"], name: "index_logbooks_on_approver_id", using: :btree
  add_index "logbooks", ["user_id"], name: "index_logbooks_on_user_id", using: :btree

  create_table "logged_days", force: :cascade do |t|
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
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "crew"
    t.boolean  "aborted"
    t.integer  "ice"
    t.text     "notes"
  end

  add_index "logged_days", ["fish_id"], name: "index_logged_days_on_fish_id", using: :btree
  add_index "logged_days", ["graticule_id"], name: "index_logged_days_on_graticule_id", using: :btree
  add_index "logged_days", ["logbook_id"], name: "index_logged_days_on_logbook_id", using: :btree

  create_table "offices", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "district_id"
  end

  create_table "protocols", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "code"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "alpha_code", limit: 255
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["user_id", "role_id"], name: "by_user_and_role", unique: true, using: :btree

  create_table "surveys", force: :cascade do |t|
    t.date     "date_published"
    t.integer  "desa_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "fishery_id"
    t.integer  "admin_id"
    t.integer  "reviewer_id"
    t.integer  "landing_enumerator_id"
    t.integer  "catch_measurer_id"
    t.integer  "catch_scribe_id"
    t.integer  "vessel_count"
    t.string   "review_state",          limit: 255, default: "pending"
    t.datetime "reviewed_at"
  end

  add_index "surveys", ["catch_measurer_id"], name: "index_surveys_on_catch_measurer_id", using: :btree
  add_index "surveys", ["catch_scribe_id"], name: "index_surveys_on_catch_scribe_id", using: :btree
  add_index "surveys", ["landing_enumerator_id"], name: "index_surveys_on_landing_enumerator_id", using: :btree
  add_index "surveys", ["reviewer_id"], name: "index_surveys_on_approver_id", using: :btree

  create_table "unloading_catches", force: :cascade do |t|
    t.integer  "fish_id"
    t.integer  "quantity"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "unloading_id"
    t.string   "cut_type"
  end

  add_index "unloading_catches", ["fish_id"], name: "index_unloading_catches_on_fish_id", using: :btree
  add_index "unloading_catches", ["unloading_id"], name: "index_unloading_catches_on_unloading_id", using: :btree

  create_table "unloadings", force: :cascade do |t|
    t.string   "port"
    t.datetime "time_out"
    t.datetime "time_in"
    t.boolean  "etp"
    t.string   "location"
    t.integer  "fuel"
    t.integer  "ice"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "vessel_id"
    t.string   "review_state",      default: "pending"
    t.integer  "byproduct"
    t.integer  "discard"
    t.integer  "yft"
    t.integer  "bet"
    t.integer  "skj"
    t.integer  "kaw"
    t.string   "catch_certificate"
    t.integer  "budget"
  end

  add_index "unloadings", ["vessel_id"], name: "index_unloadings_on_vessel_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "name",                   limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "authentication_token",   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "desa_id"
    t.string   "avatar",                 limit: 255
    t.integer  "vessel_type_id"
    t.integer  "engine_id"
    t.integer  "power"
    t.integer  "length"
    t.text     "notes"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255, null: false
    t.integer  "item_id",                    null: false
    t.string   "event",          limit: 255, null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "vessel_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "vessels", force: :cascade do |t|
    t.string   "name"
    t.integer  "vessel_type_id"
    t.integer  "gear_id"
    t.string   "flag_state"
    t.string   "year_built"
    t.integer  "length"
    t.integer  "tonnage"
    t.string   "imo_number"
    t.boolean  "shark_policy"
    t.boolean  "iuu_list"
    t.boolean  "code_of_conduct"
    t.integer  "company_id"
    t.string   "ap2hi_ref"
    t.string   "issf_ref"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "crew"
    t.integer  "hooks"
    t.string   "captain"
    t.string   "owner"
    t.string   "sipi_number"
    t.date     "sipi_expiry"
    t.string   "siup_number"
    t.boolean  "issf_ref_requested"
    t.string   "material_type"
    t.string   "machine_type"
    t.integer  "capacity"
    t.boolean  "vms"
    t.boolean  "tracker"
    t.string   "port"
    t.boolean  "name_changed"
    t.boolean  "flag_state_changed"
    t.boolean  "radio"
    t.string   "relationship_type"
    t.integer  "fish_capacity"
    t.integer  "bait_capacity"
    t.string   "location_built"
    t.string   "seafdec_ref"
    t.string   "mmaf_ref"
    t.string   "dkp_ref"
  end

  add_index "vessels", ["company_id"], name: "index_vessels_on_company_id", using: :btree
  add_index "vessels", ["gear_id"], name: "index_vessels_on_gear_id", using: :btree
  add_index "vessels", ["vessel_type_id"], name: "index_vessels_on_vessel_type_id", using: :btree

  add_foreign_key "bait_loadings", "fishes"
  add_foreign_key "bait_loadings", "unloadings"
  add_foreign_key "bait_loadings", "vessels"
  add_foreign_key "carrier_loadings", "vessels"
  add_foreign_key "unloading_catches", "fishes"
  add_foreign_key "vessels", "companies"
  add_foreign_key "vessels", "gears"
  add_foreign_key "vessels", "vessel_types"
end

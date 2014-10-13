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

ActiveRecord::Schema.define(version: 20141013003318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"
  enable_extension "pg_trgm"

  create_table "job_skill_associations", force: true do |t|
    t.integer  "job_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_skill_associations", ["job_id", "skill_id"], name: "index_job_skill_associations_on_job_id_and_skill_id", unique: true, using: :btree

  create_table "jobs", force: true do |t|
    t.string   "name",                        null: false
    t.string   "location"
    t.float    "budget"
    t.integer  "employer_id",                 null: false
    t.integer  "employee_id"
    t.boolean  "awarded",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "longitude"
    t.float    "latitude"
    t.text     "description",                 null: false
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "skills", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skill_associations", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "skill_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_skill_associations", ["user_id", "skill_id"], name: "index_user_skill_associations_on_user_id_and_skill_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "user_name",  null: false
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

end

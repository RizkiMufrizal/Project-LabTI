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

ActiveRecord::Schema.define(version: 20160509065851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "practicums", primary_key: "id_practicum", force: :cascade do |t|
    t.string   "practicum_name", limit: 50
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "projects", primary_key: "id_project", force: :cascade do |t|
    t.string   "name_project",           limit: 50
    t.string   "responsible_person",     limit: 50
    t.string   "name_file",              limit: 150
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "student_npm",            limit: 8
    t.string   "practicum_id_practicum", limit: 150
  end

  create_table "students", primary_key: "npm", force: :cascade do |t|
    t.string   "name",          limit: 50
    t.string   "class",         limit: 6
    t.string   "gender",        limit: 6
    t.text     "address"
    t.string   "password_hash", limit: 150
    t.string   "password_salt", limit: 150
    t.boolean  "enable"
    t.string   "role",          limit: 20
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", primary_key: "email", force: :cascade do |t|
    t.string   "password_hash", limit: 150
    t.string   "password_salt", limit: 150
    t.boolean  "enable"
    t.string   "role",          limit: 20
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "projects", "practicums", column: "practicum_id_practicum", primary_key: "id_practicum", on_update: :cascade, on_delete: :cascade
  add_foreign_key "projects", "students", column: "student_npm", primary_key: "npm", on_update: :cascade, on_delete: :cascade
end

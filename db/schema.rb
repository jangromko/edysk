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

ActiveRecord::Schema.define(version: 20170428233622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_types", force: :cascade do |t|
    t.string "name"
    t.integer "space"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directories", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "directory_id"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forgotten_passwords", primary_key: "hash_pk", id: :string, force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "used", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shared_directories", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "directory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["directory_id"], name: "index_shared_directories_on_directory_id"
    t.index ["user_id", "directory_id"], name: "index_shared_directories_on_user_id_and_directory_id", unique: true
    t.index ["user_id"], name: "index_shared_directories_on_user_id"
  end

  create_table "shared_files", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "user_file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_file_id"], name: "index_shared_files_on_user_file_id"
    t.index ["user_id", "user_file_id"], name: "index_shared_files_on_user_id_and_user_file_id", unique: true
    t.index ["user_id"], name: "index_shared_files_on_user_id"
  end

  create_table "user_files", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "directory_id"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["directory_id", "name"], name: "index_user_files_on_directory_id_and_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "email"
    t.string "password"
    t.string "salt"
    t.integer "account_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  add_foreign_key "directories", "directories"
  add_foreign_key "directories", "users"
  add_foreign_key "forgotten_passwords", "users"
  add_foreign_key "user_files", "directories"
  add_foreign_key "user_files", "users"
  add_foreign_key "users", "account_types"
end

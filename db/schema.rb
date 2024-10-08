# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_10_04_005413) do
  create_table "list_shares", id: :string, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "share_type", default: 0
    t.integer "list_id", null: false
    t.integer "shared_with_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_list_shares_on_id", unique: true
    t.index ["list_id"], name: "index_list_shares_on_list_id"
    t.index ["shared_with_id"], name: "index_list_shares_on_shared_with_id"
    t.index ["user_id"], name: "index_list_shares_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "wishlist_items", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "list_id", null: false
    t.index ["list_id"], name: "index_wishlist_items_on_list_id"
    t.index ["user_id"], name: "index_wishlist_items_on_user_id"
  end

  add_foreign_key "list_shares", "lists"
  add_foreign_key "list_shares", "users"
  add_foreign_key "list_shares", "users", column: "shared_with_id"
  add_foreign_key "lists", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "wishlist_items", "lists"
  add_foreign_key "wishlist_items", "users"
end

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

ActiveRecord::Schema[7.0].define(version: 2023_03_06_171455) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favourite_posts", force: :cascade do |t|
    t.string "username"
    t.string "profile_picture_url"
    t.string "caption"
    t.string "media_url"
    t.string "timestamp"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favourite_posts_on_user_id"
  end

  create_table "insta_posts", force: :cascade do |t|
    t.string "caption"
    t.string "media_url"
    t.string "timestamp"
    t.bigint "insta_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insta_profile_id"], name: "index_insta_posts_on_insta_profile_id"
  end

  create_table "insta_profiles", force: :cascade do |t|
    t.string "username"
    t.string "profile_picture_url"
    t.string "insta_id"
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_insta_profiles_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favourite_posts", "users"
  add_foreign_key "insta_posts", "insta_profiles"
  add_foreign_key "insta_profiles", "lists"
  add_foreign_key "lists", "users"
end

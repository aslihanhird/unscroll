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

ActiveRecord::Schema[7.0].define(version: 2023_03_13_101059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "controllers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_controllers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_controllers_on_reset_password_token", unique: true
  end

  create_table "favourite_insta_posts", force: :cascade do |t|
    t.string "caption"
    t.string "media_url"
    t.string "timestamp"
    t.bigint "favourite_insta_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "media_type"
    t.index ["favourite_insta_profile_id"], name: "index_favourite_insta_posts_on_favourite_insta_profile_id"
  end

  create_table "favourite_insta_profiles", force: :cascade do |t|
    t.string "username"
    t.string "profile_picture_url"
    t.bigint "favourite_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favourite_list_id"], name: "index_favourite_insta_profiles_on_favourite_list_id"
  end

  create_table "favourite_lists", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favourite_lists_on_user_id"
  end

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

  create_table "favourite_twitter_posts", force: :cascade do |t|
    t.string "caption"
    t.string "media_url"
    t.string "timestamp"
    t.bigint "favourite_twitter_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favourite_twitter_profile_id"], name: "index_favourite_twitter_posts_on_favourite_twitter_profile_id"
  end

  create_table "favourite_twitter_profiles", force: :cascade do |t|
    t.string "username"
    t.string "profile_picture_url"
    t.string "twitter_id"
    t.bigint "favourite_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favourite_list_id"], name: "index_favourite_twitter_profiles_on_favourite_list_id"
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

  create_table "posts", force: :cascade do |t|
    t.string "caption"
    t.string "media_url"
    t.integer "timestamp"
    t.string "source"
    t.string "media_type"
    t.boolean "favourite"
    t.boolean "read"
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_posts_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "username"
    t.string "profile_type"
    t.string "profile_pic"
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_source_id"
    t.index ["list_id"], name: "index_profiles_on_list_id"
  end

  create_table "twitter_posts", force: :cascade do |t|
    t.string "caption"
    t.string "media_url"
    t.string "timestamp"
    t.bigint "twitter_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitter_profile_id"], name: "index_twitter_posts_on_twitter_profile_id"
  end

  create_table "twitter_profiles", force: :cascade do |t|
    t.string "username"
    t.string "profile_picture_url"
    t.string "twitter_id"
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_twitter_profiles_on_list_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favourite_insta_posts", "favourite_insta_profiles"
  add_foreign_key "favourite_insta_profiles", "favourite_lists"
  add_foreign_key "favourite_lists", "users"
  add_foreign_key "favourite_posts", "users"
  add_foreign_key "favourite_twitter_posts", "favourite_twitter_profiles"
  add_foreign_key "favourite_twitter_profiles", "favourite_lists"
  add_foreign_key "insta_posts", "insta_profiles"
  add_foreign_key "insta_profiles", "lists"
  add_foreign_key "lists", "users"
  add_foreign_key "posts", "profiles"
  add_foreign_key "profiles", "lists"
  add_foreign_key "twitter_posts", "twitter_profiles"
  add_foreign_key "twitter_profiles", "lists"
end

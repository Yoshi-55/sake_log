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

ActiveRecord::Schema[8.0].define(version: 2025_07_22_062400) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "sake_log_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand", limit: 30
    t.string "taste", limit: 20
    t.text "memo"
    t.index ["sake_log_id"], name: "index_posts_on_sake_log_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "sake_logs", force: :cascade do |t|
    t.string "name"
    t.string "taste"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "sweetness", default: 3, null: false, comment: "甘味 (1-5)"
    t.integer "sourness", default: 3, null: false, comment: "酸味 (1-5)"
    t.integer "bitterness", default: 3, null: false, comment: "苦味 (1-5)"
    t.integer "umami", default: 3, null: false, comment: "旨味 (1-5)"
    t.integer "spiciness", default: 3, null: false, comment: "辛味 (1-5)"
    t.index ["user_id"], name: "index_sake_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "sake_logs"
  add_foreign_key "posts", "users"
  add_foreign_key "sake_logs", "users"
end

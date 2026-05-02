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

ActiveRecord::Schema[8.1].define(version: 2026_05_01_212157) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "images", force: :cascade do |t|
    t.integer "ave_value", default: 0, null: false
    t.datetime "created_at", null: false
    t.string "file", null: false
    t.string "name", null: false
    t.bigint "theme_id", null: false
    t.datetime "updated_at", null: false
    t.index ["file"], name: "index_images_on_file", unique: true
    t.index ["theme_id"], name: "index_images_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_themes_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "remember_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  create_table "values", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "image_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "value", null: false
    t.index ["image_id"], name: "index_values_on_image_id"
    t.index ["user_id", "image_id"], name: "index_values_on_user_id_and_image_id", unique: true
    t.index ["user_id"], name: "index_values_on_user_id"
  end

  add_foreign_key "images", "themes"
  add_foreign_key "values", "images"
  add_foreign_key "values", "users"
end

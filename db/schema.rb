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

ActiveRecord::Schema[8.1].define(version: 2026_03_29_064535) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "game_states", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "current_station_id", null: false
    t.integer "last_dice_result"
    t.boolean "mission_cleared", default: true, null: false
    t.integer "turn_count"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["current_station_id"], name: "index_game_states_on_current_station_id"
    t.index ["user_id"], name: "index_game_states_on_user_id"
  end

  create_table "missions", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.bigint "station_id", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_missions_on_station_id"
  end

  create_table "stamps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "mission_id", null: false
    t.bigint "station_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["mission_id"], name: "index_stamps_on_mission_id"
    t.index ["station_id"], name: "index_stamps_on_station_id"
    t.index ["user_id"], name: "index_stamps_on_user_id"
  end

  create_table "stations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.integer "order_index"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_states", "stations", column: "current_station_id"
  add_foreign_key "game_states", "users"
  add_foreign_key "missions", "stations"
  add_foreign_key "stamps", "missions"
  add_foreign_key "stamps", "stations"
  add_foreign_key "stamps", "users"
end

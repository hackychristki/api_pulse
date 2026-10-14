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

ActiveRecord::Schema[8.1].define(version: 2026_10_14_163026) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "api_checks", force: :cascade do |t|
    t.bigint "monitored_api_id", null: false
    t.integer "http_status"
    t.integer "response_time_ms"
    t.datetime "checked_at", null: false
    t.text "error_message"
    t.boolean "online", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monitored_api_id"], name: "index_api_checks_on_monitored_api_id"
  end

  create_table "monitored_apis", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.integer "expected_status", default: 200, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "api_checks", "monitored_apis"
end

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

ActiveRecord::Schema[7.0].define(version: 2023_02_13_021403) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "eventbrite_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "eventbrite_id"], name: "index_attendees_on_event_id_and_eventbrite_id", unique: true
    t.index ["event_id"], name: "index_attendees_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "eventbrite_id"
    t.string "name"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eventbrite_id"], name: "index_events_on_eventbrite_id", unique: true
  end

  create_table "giveaways", force: :cascade do |t|
    t.string "prize"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "num_winners"
    t.boolean "drawn"
    t.index ["user_id"], name: "index_giveaways_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "winners", force: :cascade do |t|
    t.bigint "giveaway_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.bigint "attendee_id", null: false
    t.index ["attendee_id"], name: "index_winners_on_attendee_id"
    t.index ["giveaway_id"], name: "index_winners_on_giveaway_id"
  end

  add_foreign_key "attendees", "events"
  add_foreign_key "giveaways", "users"
  add_foreign_key "winners", "attendees"
  add_foreign_key "winners", "giveaways"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_15_173355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "checkup_appointments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "doctor_id"
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.index ["doctor_id"], name: "index_checkup_appointments_on_doctor_id"
    t.index ["user_id"], name: "index_checkup_appointments_on_user_id"
  end

  create_table "doctors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: "", null: false
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "whitelisted_jwts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "jti", null: false
    t.string "userable_type", null: false
    t.uuid "userable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_whitelisted_jwts_on_jti", unique: true
  end

  add_foreign_key "checkup_appointments", "doctors"
  add_foreign_key "checkup_appointments", "users"
end

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

ActiveRecord::Schema.define(version: 20180125195957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fsas", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "receiver_id"
    t.text "body"
    t.boolean "read", default: false
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "survey_id"
    t.string "option_a"
    t.string "option_b"
    t.string "option_a_url"
    t.string "option_b_url"
  end

  create_table "results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "survey_id"
    t.string "answers", default: [], array: true
    t.string "matches", default: [], array: true
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "gender", default: "undefined"
    t.string "orientation", default: "undefined"
    t.string "looking_for", default: "undefined"
    t.string "phone"
    t.boolean "privacy", default: true
    t.integer "fsa_id"
    t.float "latitude"
    t.float "longitude"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text "description"
    t.text "pet_peeves"
    t.integer "income"
    t.string "status", default: "Offline"
    t.integer "blocks", default: [], array: true
  end

end

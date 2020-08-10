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

ActiveRecord::Schema.define(version: 2020_07_27_094049) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "longitude"
    t.float "latitude"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
    t.index ["latitude", "longitude"], name: "index_addresses_on_latitude_and_longitude"
  end

  create_table "amenities", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.date "move_in"
    t.date "move_out"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "booking_auth_token"
    t.date "booking_auth_token_exp"
    t.string "stripe_billing_plan"
    t.bigint "room_id"
    t.date "booking_process_invite_send"
    t.float "monthly_price"
    t.bigint "price_id"
    t.index ["price_id"], name: "index_bookings_on_price_id"
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "community_areas", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name"
    t.float "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_community_areas_on_project_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "booking_id"
    t.binary "signature"
    t.date "signed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_contracts_on_booking_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "descriptionable_type"
    t.bigint "descriptionable_id"
    t.string "field"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["descriptionable_type", "descriptionable_id"], name: "index_descs_on_descable_type_and_descable_id"
  end

  create_table "join_amenities", force: :cascade do |t|
    t.string "amenitiable_type"
    t.bigint "amenitiable_id"
    t.string "name"
    t.bigint "amenity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenitiable_type", "amenitiable_id"], name: "index_join_amenities_on_amenitiable_type_and_amenitiable_id"
    t.index ["amenity_id"], name: "index_join_amenities_on_amenity_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.string "email"
    t.string "phone_code"
    t.string "phone"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefered_suites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "roomtype_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roomtype_id"], name: "index_prefered_suites_on_roomtype_id"
    t.index ["user_id"], name: "index_prefered_suites_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.string "duration"
    t.float "amount"
    t.bigint "roomtype_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_plan_id"
    t.index ["roomtype_id"], name: "index_prices_on_roomtype_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "inactive"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "intern_number"
    t.string "house_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "roomtype_id"
    t.index ["roomtype_id"], name: "index_rooms_on_roomtype_id"
  end

  create_table "roomtypes", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name"
    t.float "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_product"
    t.integer "amount_of_people", default: 1
    t.string "stripe_product_id"
    t.index ["project_id"], name: "index_roomtypes_on_project_id"
  end

  create_table "social_links", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_social_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "applicant"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "job"
    t.integer "amount_of_people", default: 1
    t.string "gender"
    t.string "phone_number"
    t.string "phone_code"
    t.string "stripe_id"
    t.string "stripe_subscription_id"
    t.boolean "subscribed"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.string "card_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "welcome_calls", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "booking_id"
    t.boolean "available", default: true
    t.index ["booking_id"], name: "index_welcome_calls_on_booking_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "prices"
  add_foreign_key "bookings", "users"
  add_foreign_key "community_areas", "projects"
  add_foreign_key "contracts", "bookings"
  add_foreign_key "join_amenities", "amenities"
  add_foreign_key "prefered_suites", "roomtypes"
  add_foreign_key "prefered_suites", "users"
  add_foreign_key "prices", "roomtypes"
  add_foreign_key "roomtypes", "projects"
  add_foreign_key "social_links", "users"
  add_foreign_key "welcome_calls", "bookings"
end

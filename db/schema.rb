# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151116233339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.boolean  "primary",    default: false
    t.integer  "user_id",                    null: false
    t.string   "address",                    null: false
    t.string   "zip_code",                   null: false
    t.string   "state",                      null: false
    t.string   "appt_num"
    t.string   "city",                       null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "addresses", ["latitude", "longitude"], name: "index_addresses_on_latitude_and_longitude", using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "completion_id", null: false
    t.integer  "question_id",   null: false
    t.string   "text",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "start_time",                 null: false
    t.datetime "end_time",                   null: false
    t.integer  "order_id"
    t.integer  "stylist_id"
    t.integer  "client_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "cancelled",  default: false
  end

  add_index "appointments", ["client_id"], name: "index_appointments_on_client_id", using: :btree
  add_index "appointments", ["order_id"], name: "index_appointments_on_order_id", using: :btree
  add_index "appointments", ["stylist_id"], name: "index_appointments_on_stylist_id", using: :btree

  create_table "completions", force: :cascade do |t|
    t.integer  "survey_id",  null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "confirm_submittables", force: :cascade do |t|
    t.boolean  "confirmed",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "global_settings", force: :cascade do |t|
    t.integer  "appointment_buffer"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "multiple_choice_submittables", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer  "question_id", null: false
    t.string   "text",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "service_product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",         precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price",        precision: 12, scale: 3
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["service_product_id"], name: "index_order_items_on_service_product_id", using: :btree

  create_table "order_photos", force: :cascade do |t|
    t.string   "image"
    t.string   "description"
    t.string   "purpose"
    t.integer  "order_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "order_photos", ["order_id"], name: "index_order_photos_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",         precision: 12, scale: 3
    t.decimal  "tax",              precision: 12, scale: 3
    t.decimal  "total",            precision: 12, scale: 3
    t.string   "state",                                     default: "pending"
    t.integer  "gratuity"
    t.datetime "cancelled_at"
    t.datetime "authorized_at"
    t.datetime "captured_at"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "stripe_charge_id"
    t.integer  "cancelled_by"
  end

  create_table "payment_infos", force: :cascade do |t|
    t.string   "stripe_customer_token"
    t.string   "stripe_card_token"
    t.integer  "user_id"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "stripe_bank_token"
    t.decimal  "gratuity_rate",         precision: 12, scale: 3, default: 0.0
  end

  create_table "product_searches", force: :cascade do |t|
    t.string   "term"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title",            null: false
    t.integer  "survey_id",        null: false
    t.integer  "submittable_id"
    t.string   "submittable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "first_name",   null: false
    t.string   "last_name",    null: false
    t.string   "phone_number", null: false
    t.string   "gender",       null: false
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "avatar"
    t.string   "avatar_cache"
    t.text     "bio"
    t.date     "dob"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "stylist_id", null: false
    t.string   "state"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_menus", force: :cascade do |t|
    t.string   "name"
    t.boolean  "licence_required", default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "service_products", force: :cascade do |t|
    t.string   "name",                                                            null: false
    t.integer  "minute_duration",                                                 null: false
    t.integer  "hours"
    t.integer  "minutes"
    t.decimal  "price",                    precision: 8, scale: 2,                null: false
    t.text     "details"
    t.text     "preparation_instructions"
    t.boolean  "displayed",                                        default: true
    t.integer  "service_id",                                                      null: false
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  create_table "services", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "service_menu_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "stylist_photos", force: :cascade do |t|
    t.integer  "stylist_id"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "stylist_reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "body"
    t.integer  "client_id"
    t.integer  "stylist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stylist_reviews", ["client_id"], name: "index_stylist_reviews_on_client_id", using: :btree
  add_index "stylist_reviews", ["stylist_id"], name: "index_stylist_reviews_on_stylist_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_intervals", force: :cascade do |t|
    t.string   "title"
    t.integer  "week_day_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "appointment_id"
  end

  add_index "time_intervals", ["week_day_id"], name: "index_time_intervals_on_week_day_id", using: :btree

  create_table "user_settings", force: :cascade do |t|
    t.boolean  "enable_booking",     default: true
    t.boolean  "multiple_services",  default: false
    t.boolean  "premium_membership", default: false
    t.boolean  "booking_texts",      default: false
    t.boolean  "booking_emails",     default: false
    t.boolean  "verified",           default: false
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username",                               null: false
    t.boolean  "agree_to_terms",         default: false
    t.string   "role"
    t.jsonb    "settings",               default: {},    null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "banned",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "week_days", force: :cascade do |t|
    t.integer  "schedule_id"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "day_of_week"
  end

  add_foreign_key "appointments", "orders"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "service_products"
  add_foreign_key "order_photos", "orders"
  add_foreign_key "time_intervals", "week_days"
end

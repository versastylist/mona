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

ActiveRecord::Schema.define(version: 20151002235907) do

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
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "completion_id", null: false
    t.integer  "question_id",   null: false
    t.string   "text",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

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

  create_table "options", force: :cascade do |t|
    t.integer  "question_id", null: false
    t.string   "text",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "payment_infos", force: :cascade do |t|
    t.string   "stripe_customer_token"
    t.string   "stripe_card_token"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "stripe_bank_token"
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
    t.string   "dob",          null: false
    t.string   "gender",       null: false
    t.string   "facebook"
    t.string   "linked_in"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "avatar"
    t.string   "avatar_cache"
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

  create_table "surveys", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "week_days", force: :cascade do |t|
    t.date     "day_of_week",                null: false
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "schedule_id"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end

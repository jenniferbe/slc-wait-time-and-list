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

ActiveRecord::Schema.define(version: 20171202232341) do

  create_table "history_entries", force: :cascade do |t|
    t.integer  "student_id",   limit: 8
    t.string   "course"
    t.integer  "tutor_sid",    limit: 8
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "tutor_notes"
    t.string   "status"
    t.string   "meet_type"
    t.datetime "sign_in_time"
  end

  create_table "student_requests", force: :cascade do |t|
    t.integer  "student_id", limit: 8
    t.string   "course"
    t.string   "meet_type"
    t.string   "status"
    t.time     "wait_time"
    t.integer  "tutor_id",   limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "emailed"
    t.datetime "start_time"
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sid",                    limit: 8
    t.string   "email"
    t.boolean  "transfer_student"
    t.boolean  "concurrency_student"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "domestic_student"
    t.string   "concurrent_institution"
  end

  create_table "tutor_work_days", force: :cascade do |t|
    t.integer  "tutor_id",     limit: 8
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "num_students"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tutors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sid",                    limit: 8
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "active",                           default: false
  end

  add_index "tutors", ["email"], name: "index_tutors_on_email", unique: true
  add_index "tutors", ["reset_password_token"], name: "index_tutors_on_reset_password_token", unique: true

end

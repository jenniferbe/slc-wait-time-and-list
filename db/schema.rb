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

ActiveRecord::Schema.define(version: 20171029045053) do

  create_table "active_sessions", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "course"
    t.time     "wait_time"
    t.integer  "tutor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drop_in_histories", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "course"
    t.integer  "tutor_sid"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "tutor_notes"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scheduled_appointments", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_queues", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "course"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sid"
    t.string   "email"
    t.boolean  "transfer_student"
    t.boolean  "concurrency_student"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "tutor_work_days", force: :cascade do |t|
    t.integer  "tutor_id"
    t.integer  "start_time"
    t.integer  "end_time"
    t.string   "num_students"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tutors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weekly_appointments", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

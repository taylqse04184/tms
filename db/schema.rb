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

ActiveRecord::Schema.define(version: 20131209103116) do

  create_table "activities", force: true do |t|
    t.integer  "trainee_id"
    t.integer  "course_id"
    t.integer  "subject_id"
    t.integer  "task_id"
    t.integer  "temp_type"
    t.integer  "active_flag", default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conclusions", force: true do |t|
    t.integer  "enrollment_id"
    t.string   "content",       limit: 4,             null: false
    t.text     "comment",                             null: false
    t.integer  "active_flag",             default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conclusions", ["enrollment_id"], name: "fk_Enroll_idx", using: :btree

  create_table "course_subject_tasks", force: true do |t|
    t.integer  "course_subject_id",             null: false
    t.integer  "subject_id",                    null: false
    t.integer  "task_id",                       null: false
    t.integer  "active_flag",       default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_subjects", force: true do |t|
    t.integer  "course_id"
    t.integer  "subject_id"
    t.string   "status",      limit: 1, default: "N", null: false
    t.integer  "active_flag",           default: 1
    t.datetime "start_date"
    t.integer  "duration"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_subjects", ["course_id"], name: "fk_Course_Subject_1", using: :btree
  add_index "course_subjects", ["subject_id"], name: "fk_Course_Subject_2", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name",        limit: 128,               null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "active_flag",             default: 1
    t.string   "status",      limit: 1,   default: "N", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollment_subjects", force: true do |t|
    t.integer  "subject_id"
    t.integer  "trainee_id"
    t.integer  "course_id"
    t.integer  "enrollment_id"
    t.string   "status",        limit: 1, default: "N", null: false
    t.datetime "start_date"
    t.integer  "active_flag",             default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollment_subjects", ["enrollment_id"], name: "fk_Enroll_idx", using: :btree

  create_table "enrollment_tasks", force: true do |t|
    t.integer  "subject_id"
    t.integer  "task_id"
    t.integer  "enrollment_subject_id",                         null: false
    t.string   "status",                limit: 1, default: "N", null: false
    t.integer  "active_flag",                     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollment_tasks", ["enrollment_subject_id"], name: "fk_Subject_idx", using: :btree

  create_table "enrollments", force: true do |t|
    t.integer  "trainee_id"
    t.integer  "course_id"
    t.string   "status",        limit: 1, default: "N", null: false
    t.integer  "active_flag",             default: 1
    t.integer  "conclusion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["conclusion_id"], name: "fk_Enrollments_3", using: :btree
  add_index "enrollments", ["course_id"], name: "fk_Enrollments_2", using: :btree
  add_index "enrollments", ["trainee_id"], name: "fk_Enrollments_1", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name",        limit: 128,             null: false
    t.text     "description",                         null: false
    t.integer  "duration"
    t.integer  "active_flag",             default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supervisor_courses", force: true do |t|
    t.integer  "supervisor_id"
    t.integer  "course_id"
    t.integer  "active_flag",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supervisors", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "active_flag",     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "subject_id",                          null: false
    t.string   "name",        limit: 128
    t.string   "description", limit: 512
    t.integer  "active_flag",             default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_index"
  end

  add_index "tasks", ["subject_id"], name: "fk_Tasks_1", using: :btree

  create_table "trainees", force: true do |t|
    t.string   "name",              limit: 45,              null: false
    t.string   "email",             limit: 45,              null: false
    t.string   "password_digest",   limit: 200,             null: false
    t.string   "remember_token"
    t.integer  "current_course_id"
    t.integer  "active_flag",                   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trainees", ["email"], name: "email_UNIQUE", unique: true, using: :btree
  add_index "trainees", ["remember_token"], name: "index_trainees_on_remember_token", using: :btree

end

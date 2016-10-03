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


ActiveRecord::Schema.define(version: 20161003073206) do

  create_table "answerusers", force: :cascade do |t|
    t.integer  "userquestion_id", limit: 4
    t.integer  "option_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.string   "value",       limit: 255
    t.boolean  "istrue",      limit: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "order",       limit: 4
  end

  create_table "questions", force: :cascade do |t|
    t.text     "name",       limit: 65535
    t.text     "question",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "questiontypeassocs", force: :cascade do |t|
    t.integer  "question_id",     limit: 4
    t.integer  "questiontype_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "questiontypes", force: :cascade do |t|
    t.string   "qtype",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "testquestions", force: :cascade do |t|
    t.integer  "test_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "order",       limit: 4
  end

  create_table "tests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.time     "examtime"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "type",       limit: 255
  end

  create_table "testusers", force: :cascade do |t|
    t.integer  "test_id",         limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "realtestuser_id", limit: 4
    t.datetime "starttime"
    # t.datetime "startedtime"
  end

  create_table "userquestions", force: :cascade do |t|
    t.integer  "testuser_id", limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "role",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

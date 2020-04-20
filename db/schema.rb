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

ActiveRecord::Schema.define(version: 20200414010150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "category_banks", force: :cascade do |t|
    t.string   "category"
    t.string   "reviewStatus"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "creator"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "rating"
    t.text     "description"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_banks", force: :cascade do |t|
    t.string   "category"
    t.text     "question"
    t.string   "option1"
    t.string   "option2"
    t.string   "option3"
    t.string   "option4"
    t.string   "option5"
    t.integer  "answer"
    t.string   "reviewStatus"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "creator"
    t.string   "explaination"
    t.boolean  "bookmark"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "current_place"
    t.boolean  "is_admin"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "reviewStatus"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "last_login_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "password_digest"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end

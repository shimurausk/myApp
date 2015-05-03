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

ActiveRecord::Schema.define(version: 20150420161520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.boolean  "status"
    t.string   "category"
  end

  create_table "comments", force: true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["blog_id"], name: "index_comments_on_blog_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "genre"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "day"
    t.datetime "time"
    t.integer  "member"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "staff_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  create_table "staffs", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "address"
    t.integer  "age"
    t.string   "post"
    t.integer  "hourlywage"
    t.text     "memo"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["blog_id"], name: "index_taggings_on_blog_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "works", force: true do |t|
    t.datetime "date"
    t.datetime "start"
    t.datetime "end"
    t.datetime "break"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "works", ["staff_id"], name: "index_works_on_staff_id", using: :btree

end

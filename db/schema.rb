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

ActiveRecord::Schema.define(version: 20160301093151) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "project_id", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "accesses", ["project_id"], name: "index_accesses_on_project_id", using: :btree
  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "team_id",    limit: 4
  end

  add_index "projects", ["team_id"], name: "index_projects_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string   "content",     limit: 255
    t.integer  "creator_id",  limit: 4
    t.integer  "executor_id", limit: 4
    t.string   "state",       limit: 255, default: "opened"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "project_id",  limit: 4
  end

  add_index "todos", ["project_id"], name: "index_todos_on_project_id", using: :btree
  add_index "todos", ["state"], name: "index_todos_on_state", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "projects", "teams"
  add_foreign_key "todos", "projects"
end

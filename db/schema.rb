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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120712035446) do

  create_table "assets", :force => true do |t|
    t.string  "ticker"
    t.float   "evaluation"
    t.integer "volume"
    t.integer "market_cap"
    t.float   "beta"
    t.date    "date"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "rsvps", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "uid"
    t.boolean  "confirmed",         :default => false
    t.string   "confirmation_code"
  end

  add_index "rsvps", ["email"], :name => "index_rsvps_on_email", :unique => true
  add_index "rsvps", ["uid"], :name => "index_rsvps_on_uid", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.string   "uid"
    t.string   "confirmation_code"
    t.string   "country"
    t.string   "state"
    t.string   "remember_token"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "status"
  end

  add_index "users", ["confirmation_code"], :name => "index_users_on_confirmation_code"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

end

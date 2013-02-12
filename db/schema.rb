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

ActiveRecord::Schema.define(:version => 20130212212604) do

  create_table "bets", :force => true do |t|
    t.integer   "user_id"
    t.integer   "day_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "credits", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "used",       :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "credits", ["user_id"], :name => "index_credits_on_user_id"

  create_table "days", :force => true do |t|
    t.date      "date"
    t.integer   "capability"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer   "value"
    t.integer   "day_id"
    t.integer   "user_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.string    "data"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "slots", :force => true do |t|
    t.integer   "user_id"
    t.integer   "day_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string    "email",                                 :default => "",    :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                                               :null => false
    t.timestamp "updated_at",                                               :null => false
    t.string    "provider"
    t.string    "uid"
    t.string    "name"
    t.boolean   "banned",                                :default => false
    t.integer   "ban_count",                             :default => 0
    t.boolean   "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

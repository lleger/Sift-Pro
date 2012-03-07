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

ActiveRecord::Schema.define(:version => 20120307004934) do

  create_table "athletes", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "sport_id"
    t.integer  "university_id"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "issues", :force => true do |t|
    t.text     "tweet"
    t.text     "blacklisted_words"
    t.integer  "university_id"
    t.integer  "athlete_id"
    t.text     "response"
    t.boolean  "approved"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.integer  "university_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

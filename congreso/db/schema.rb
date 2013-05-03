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

ActiveRecord::Schema.define(:version => 20130502155317) do

  create_table "bookmark_sets", :force => true do |t|
    t.string   "typ"
    t.string   "name"
    t.integer  "session_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bookmarks", :force => true do |t|
    t.string   "type"
    t.integer  "pos"
    t.integer  "session_id"
    t.integer  "person_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "typ"
    t.integer  "textpos"
    t.integer  "testlength"
    t.integer  "length"
    t.integer  "bookmark_set_id"
    t.integer  "textlength"
    t.string   "title"
    t.float    "score"
    t.integer  "text_bookmark_id"
    t.string   "matchtyp"
  end

  create_table "chambers", :force => true do |t|
    t.string   "name"
    t.string   "photo_medium"
    t.string   "photo_small"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "disabled"
  end

  create_table "parties", :force => true do |t|
    t.string   "name"
    t.string   "photo_small"
    t.string   "photo_medium"
    t.string   "wikipedia"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "website"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "photo_small"
    t.string   "photo_medium"
    t.string   "wikipedia"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "website"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "party_id"
    t.integer  "province_id"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.date     "date"
    t.string   "chamber"
    t.string   "name"
    t.text     "transcript"
    t.string   "video_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "length"
    t.integer  "chamber_id"
    t.integer  "meeting"
    t.integer  "period"
    t.boolean  "disabled"
  end

  create_table "text_bookmarks", :force => true do |t|
    t.integer  "pos"
    t.integer  "length"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "person_id"
    t.integer  "session_id"
    t.string   "typ"
    t.string   "title"
    t.integer  "bookmark_id"
  end

  create_table "video_bookmarks", :force => true do |t|
    t.string   "type"
    t.integer  "pos"
    t.integer  "session_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

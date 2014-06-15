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

ActiveRecord::Schema.define(version: 20140614204934) do

  create_table "games", force: true do |t|
    t.text     "description"
    t.text     "summary"
    t.text     "variations"
    t.text     "example"
    t.integer  "maximum"
    t.integer  "minimum"
    t.integer  "total_stars",       default: 0
    t.integer  "num_of_reviews",    default: 0
    t.integer  "average_rating",    default: 0
    t.boolean  "early_childhood"
    t.boolean  "elementary_school"
    t.boolean  "middle_school"
    t.boolean  "high_school"
    t.boolean  "college"
    t.boolean  "adulthood"
    t.boolean  "is_an_exercise"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "names", force: true do |t|
    t.string   "content"
    t.integer  "popularity", default: 1
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", id: false, force: true do |t|
    t.integer  "game_id",     null: false
    t.integer  "relation_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.integer "num_of_stars"
  end

  create_table "tagizations", id: false, force: true do |t|
    t.integer  "game_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: true do |t|
    t.string   "content"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variations", force: true do |t|
    t.string   "content"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

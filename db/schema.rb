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

ActiveRecord::Schema.define(version: 20140410180010) do

  create_table "games", force: true do |t|
    t.text     "instructions"
    t.text     "example_script"
    t.integer  "maximum"
    t.integer  "minimum"
    t.integer  "likes",             default: 0
    t.boolean  "early_childhood"
    t.boolean  "elementary_school"
    t.boolean  "middle_school"
    t.boolean  "high_school"
    t.boolean  "college"
    t.boolean  "adulthood"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "names", force: true do |t|
    t.string   "content"
    t.integer  "popularity", default: 0
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

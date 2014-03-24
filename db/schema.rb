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

ActiveRecord::Schema.define(:version => 20140323182055) do

  create_table "add_our_value_to_players", :force => true do |t|
    t.integer  "ourValue"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "add_sbc_score_to_teams", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "add_team_p_to_players", :force => true do |t|
    t.string   "team_pos"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "add_team_pos_to_players", :force => true do |t|
    t.string   "teamPos"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "add_team_position_to_players", :force => true do |t|
    t.string   "teamPos"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ab"
    t.integer  "r"
    t.integer  "hr"
    t.integer  "rbi"
    t.integer  "bb"
    t.integer  "k"
    t.integer  "sb"
    t.float    "avg"
    t.float    "obp"
    t.float    "slg"
    t.float    "ops"
    t.string   "notes"
    t.integer  "value"
    t.integer  "espnValue"
    t.integer  "espnId"
    t.string   "mlbTeam"
    t.string   "position"
    t.string   "espnNotes"
    t.integer  "team_id"
    t.integer  "sbcValue"
    t.string   "tp"
    t.integer  "g"
    t.integer  "gs"
    t.float    "ip"
    t.integer  "pbb"
    t.integer  "pk"
    t.integer  "w"
    t.integer  "sv"
    t.integer  "hd"
    t.float    "era"
    t.float    "whip"
    t.float    "k9"
    t.integer  "starter_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "teamName"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sbcScore"
    t.integer  "year_id"
  end

  create_table "years", :force => true do |t|
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "team_id"
    t.boolean  "active"
  end

end

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

ActiveRecord::Schema.define(:version => 20110817183841) do

  create_table "attendances", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["event_id"], :name => "index_attendances_on_event_id"
  add_index "attendances", ["user_id"], :name => "index_attendances_on_user_id"

  create_table "conferences", :force => true do |t|
    t.string   "name"
    t.string   "hashtag"
    t.string   "domain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "organizer_id"
    t.string   "name"
    t.string   "location_name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "approved"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conference_id"
  end

  add_index "events", ["conference_id"], :name => "index_events_on_conference_id"
  add_index "events", ["organizer_id"], :name => "index_events_on_organizer_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "facebook_id"
    t.string   "twitter_id"
    t.string   "facebook_token"
    t.string   "twitter_token"
    t.string   "twitter_secret"
    t.string   "twitter_name"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salesforce_id"
  end

  add_index "users", ["salesforce_id"], :name => "index_users_on_salesforce_id"

end

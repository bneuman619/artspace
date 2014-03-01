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

ActiveRecord::Schema.define(version: 20140228221011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.integer  "administrator_id"
    t.integer  "space_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["administrator_id"], name: "index_admins_on_administrator_id", using: :btree
  add_index "admins", ["space_id"], name: "index_admins_on_space_id", using: :btree

  create_table "availabilities", force: true do |t|
    t.integer  "space_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "availabilities", ["space_id"], name: "index_availabilities_on_space_id", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "creator_id"
    t.string   "secret_api_key"
    t.string   "publishable_api_key"
    t.string   "refresh_token"
    t.string   "stripe_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["creator_id"], name: "index_payments_on_creator_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "space_id"
    t.string   "title"
    t.string   "url"
    t.string   "short_description"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["space_id"], name: "index_photos_on_space_id", using: :btree

  create_table "reservations", force: true do |t|
    t.integer  "renter_id"
    t.integer  "space_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "num_people"
    t.text     "intended_use"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["renter_id"], name: "index_reservations_on_renter_id", using: :btree
  add_index "reservations", ["space_id"], name: "index_reservations_on_space_id", using: :btree

  create_table "space_uses", force: true do |t|
    t.integer  "use_id"
    t.integer  "space_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "space_uses", ["space_id"], name: "index_space_uses_on_space_id", using: :btree
  add_index "space_uses", ["use_id"], name: "index_space_uses_on_use_id", using: :btree

  create_table "spaces", force: true do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.text     "description"
    t.string   "dimensions"
    t.text     "ammenities"
    t.float    "rate"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.string   "email"
    t.integer  "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spaces", ["creator_id"], name: "index_spaces_on_creator_id", using: :btree

  create_table "stripes", force: true do |t|
    t.integer  "creator_id"
    t.string   "secret_api_key"
    t.string   "publishable_api_key"
    t.string   "refresh_token"
    t.string   "stripe_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stripes", ["creator_id"], name: "index_stripes_on_creator_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "phone"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uses", force: true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

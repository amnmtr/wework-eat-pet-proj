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

ActiveRecord::Schema.define(version: 20190806135259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token", null: false
    t.string "token_owner"
    t.string "status", default: "active"
    t.boolean "is_general", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_token", "status"], name: "index_api_keys_on_access_token_and_status"
    t.index ["access_token"], name: "index_api_keys_on_access_token", unique: true
  end

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
    t.binary "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.string "order_id"
    t.string "customer_name"
    t.datetime "time"
    t.datetime "publish_time"
    t.string "status"
    t.json "info", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_orders_on_order_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.boolean "accepts_10bis", default: false
    t.integer "max_delivery_time"
    t.json "coordinates"
    t.bigint "cuisine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_restaurants_on_cuisine_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.string "name"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
  end

  add_foreign_key "orders", "restaurants"
  add_foreign_key "restaurants", "cuisines"
  add_foreign_key "reviews", "restaurants"
end

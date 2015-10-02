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

ActiveRecord::Schema.define(version: 20151002182732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "barista", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "barista", ["name"], name: "index_barista_on_name", using: :btree

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "customers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "email_id"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "menu_item_id"
    t.uuid     "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.integer  "price_in_cents", default: 200, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["name"], name: "index_menu_items_on_name", using: :btree

  create_table "order_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "menu_item_id"
    t.uuid     "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "amount_in_cents", default: 0,      null: false
    t.uuid     "customer_id"
    t.uuid     "barista_id"
    t.string   "status",          default: "OPEN"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "sales_aggregates", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "menu_item_id"
    t.integer  "sale_count",         default: 0
    t.integer  "sales_amount_total", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

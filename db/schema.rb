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

ActiveRecord::Schema.define(version: 20140212224130) do

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.integer  "review"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", primary_key: "category_id", force: true do |t|
    t.string   "category_name"
    t.integer  "api_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crawl_results", primary_key: "api_type", force: true do |t|
    t.integer  "offset"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "products", force: true do |t|
    t.integer  "api_type"
    t.string   "product_name"
    t.text     "description"
    t.string   "url"
    t.string   "image_small_url"
    t.string   "image_medium_url"
    t.string   "affiliate_url"
    t.integer  "product_id"
    t.integer  "category_id"
    t.string   "category_name"
    t.string   "maker_name"
    t.integer  "fixed_price"
    t.integer  "default_price"
    t.integer  "sale_price"
    t.integer  "period_start"
    t.integer  "period_end"
    t.integer  "review_average"
    t.integer  "total_reviews"
    t.integer  "total_used"
    t.integer  "used_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

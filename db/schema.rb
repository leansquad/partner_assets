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

ActiveRecord::Schema.define(version: 20150914062551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "dblink"

  create_table "requests", force: :cascade do |t|
    t.integer  "quickbase_id"
    t.string   "background_color",             null: false
    t.text     "terms",                        null: false
    t.text     "city_or_state",                null: false
    t.text     "physical_address",             null: false
    t.text     "company_overview",             null: false
    t.text     "product_feature",              null: false
    t.string   "card_type",                    null: false
    t.string   "balance_enquire_method",       null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "product_image_file_name"
    t.string   "product_image_content_type"
    t.integer  "product_image_file_size"
    t.datetime "product_image_updated_at"
    t.string   "partner_logo_file_name"
    t.string   "partner_logo_content_type"
    t.integer  "partner_logo_file_size"
    t.datetime "partner_logo_updated_at"
    t.string   "gift_card_image_file_name"
    t.string   "gift_card_image_content_type"
    t.integer  "gift_card_image_file_size"
    t.datetime "gift_card_image_updated_at"
  end

end

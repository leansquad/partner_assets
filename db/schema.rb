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

ActiveRecord::Schema.define(version: 20160528071752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "enrollment_forms", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.string   "enrollment_uid"
    t.boolean  "success"
    t.string   "of_approval_status"
    t.string   "of_submit_timestamp"
    t.string   "of_partner_rep_name"
    t.string   "of_partner_rep_title"
    t.string   "of_partner_rep_email"
    t.string   "of_terms_and_conditions"
    t.string   "of_authorized_to_sign"
    t.string   "of_decline_offer_reasons"
    t.inet     "of_partner_ip"
    t.text     "of_partner_location"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "offer_id"
    t.integer  "quickbase_id"
    t.string   "background_color",              null: false
    t.text     "terms",                         null: false
    t.text     "city_or_state",                 null: false
    t.text     "physical_address",              null: false
    t.text     "company_overview",              null: false
    t.text     "product_feature",               null: false
    t.string   "card_type"
    t.string   "balance_enquire_method",        null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
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
    t.string   "product_image2_file_name"
    t.string   "product_image2_content_type"
    t.integer  "product_image2_file_size"
    t.datetime "product_image2_updated_at"
    t.string   "partner_logo2_file_name"
    t.string   "partner_logo2_content_type"
    t.integer  "partner_logo2_file_size"
    t.datetime "partner_logo2_updated_at"
    t.string   "gift_card_image2_file_name"
    t.string   "gift_card_image2_content_type"
    t.integer  "gift_card_image2_file_size"
    t.datetime "gift_card_image2_updated_at"
    t.string   "product_image3_file_name"
    t.string   "product_image3_content_type"
    t.integer  "product_image3_file_size"
    t.datetime "product_image3_updated_at"
    t.string   "product_image4_file_name"
    t.string   "product_image4_content_type"
    t.integer  "product_image4_file_size"
    t.datetime "product_image4_updated_at"
  end

  add_index "requests", ["quickbase_id"], name: "index_requests_on_quickbase_id", using: :btree

end

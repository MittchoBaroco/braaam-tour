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

ActiveRecord::Schema.define(version: 2018_04_25_133046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "awards", force: :cascade do |t|
    t.string "caption", null: false
    t.string "institution", null: false
    t.string "country", null: false
    t.string "award_year", null: false
    t.bigint "tour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["award_year"], name: "index_awards_on_award_year"
    t.index ["caption", "institution", "award_year"], name: "index_awards_on_caption_and_institution_and_award_year", unique: true
    t.index ["tour_id"], name: "index_awards_on_tour_id"
  end

  create_table "booking_dates", force: :cascade do |t|
    t.date "day", null: false
    t.bigint "tour_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "close"
    t.index ["company_id"], name: "index_booking_dates_on_company_id"
    t.index ["day", "tour_id"], name: "index_booking_dates_on_day_and_tour_id", unique: true
    t.index ["tour_id"], name: "index_booking_dates_on_tour_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "author_name", null: false
    t.text "comment_body", null: false
    t.bigint "tour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_name", "comment_body", "tour_id"], name: "index_unique_comments", unique: true
    t.index ["tour_id"], name: "index_comments_on_tour_id"
  end

  create_table "companies", force: :cascade do |t|
    t.citext "email", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
  end

  create_table "managers", force: :cascade do |t|
    t.citext "email", default: "", null: false
    t.string "full_name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["full_name"], name: "index_managers_on_full_name", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "tours", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "video_uri"
    t.boolean "tech_help", null: false
    t.boolean "housing", null: false
    t.boolean "catering", null: false
    t.boolean "transport", null: false
    t.integer "price_braaam_cents", default: 0, null: false
    t.string "price_braaam_currency", default: "EUR", null: false
    t.integer "price_normal_cents", default: 0, null: false
    t.string "price_normal_currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tour_caption", default: "", null: false
    t.string "artist_country", default: "", null: false
    t.index ["title"], name: "index_tours_on_title"
  end

  add_foreign_key "awards", "tours"
  add_foreign_key "booking_dates", "companies"
  add_foreign_key "booking_dates", "tours"
  add_foreign_key "comments", "tours"
end

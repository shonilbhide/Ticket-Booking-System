# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_30_201543) do

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.string "address"
    t.string "credit_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.string "address"
    t.string "credit_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "feedback"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "passenger_id", null: false
    t.integer "train_id", null: false
    t.index ["passenger_id"], name: "index_reviews_on_passenger_id"
    t.index ["train_id"], name: "index_reviews_on_train_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "confirmation_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "passenger_id", null: false
    t.integer "train_id", null: false
    t.integer "creator_id", null: false
    t.index ["creator_id"], name: "index_tickets_on_creator_id"
    t.index ["passenger_id"], name: "index_tickets_on_passenger_id"
    t.index ["train_id"], name: "index_tickets_on_train_id"
  end

  create_table "trains", force: :cascade do |t|
    t.string "train_number"
    t.string "departure_station"
    t.string "termination_station"
    t.date "departure_date"
    t.time "departure_time"
    t.date "arrival_date"
    t.time "arrival_time"
    t.decimal "ticket_price"
    t.integer "train_capacity"
    t.integer "seats_left"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "reviews", "passengers"
  add_foreign_key "reviews", "trains"
  add_foreign_key "tickets", "passengers"
  add_foreign_key "tickets", "passengers", column: "creator_id"
  add_foreign_key "tickets", "trains"
end

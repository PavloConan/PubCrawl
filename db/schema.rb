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

ActiveRecord::Schema[7.0].define(version: 2022_08_20_185833) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "item_prices", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.bigint "item_id", null: false
    t.float "price"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "faulty_xpath", default: false
    t.boolean "page_not_found", default: false
    t.index ["item_id"], name: "index_item_prices_on_item_id"
    t.index ["price"], name: "index_item_prices_on_price"
    t.index ["vendor_id"], name: "index_item_prices_on_vendor_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_items_on_category"
    t.index ["name"], name: "index_items_on_name", unique: true
  end

  create_table "potential_items", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "marked_for_promotion", default: false
    t.integer "category"
    t.index ["name"], name: "index_potential_items_on_name"
    t.index ["vendor_id"], name: "index_potential_items_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "sys_name"
    t.string "url"
    t.float "shipment_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price_xpath"
  end

  add_foreign_key "item_prices", "items"
  add_foreign_key "item_prices", "vendors"
  add_foreign_key "potential_items", "vendors"
end

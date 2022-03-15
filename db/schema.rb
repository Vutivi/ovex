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

ActiveRecord::Schema.define(version: 2022_03_15_095741) do

  create_table "account_histories", force: :cascade do |t|
    t.float "balance", null: false
    t.float "locked", null: false
    t.integer "event", default: 0
    t.float "change_amount", null: false
    t.string "loggable_type"
    t.integer "loggable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["loggable_type", "loggable_id"], name: "index_account_histories_on_loggable"
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "currency_id", null: false
    t.float "balance", default: 0.0, null: false
    t.float "locked", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
    t.index ["member_id"], name: "index_accounts_on_member_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "symbol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deposits", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "currency_id", null: false
    t.float "amount", null: false
    t.float "fee", null: false
    t.string "aasm_state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_id"], name: "index_deposits_on_currency_id"
    t.index ["member_id"], name: "index_deposits_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "currencies"
  add_foreign_key "accounts", "members"
  add_foreign_key "deposits", "currencies"
  add_foreign_key "deposits", "members"
end

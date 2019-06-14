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

ActiveRecord::Schema.define(version: 2019_06_13_141040) do

  create_table "financials", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "issuer_id"
    t.integer "year"
    t.integer "period"
    t.string "currency"
    t.bigint "outstanding_shares"
    t.bigint "market_capitalization"
    t.bigint "assets"
    t.bigint "liabilities"
    t.bigint "equity"
    t.bigint "net_debt"
    t.bigint "sales"
    t.bigint "gross_profit"
    t.bigint "operating_profit"
    t.bigint "ebitda"
    t.bigint "net_profit"
    t.bigint "operating_cash_flow"
    t.bigint "free_cash_flow"
    t.float "price_earning_ratio"
    t.float "price_to_book_value_ratio"
    t.float "book_value_per_share"
    t.float "earning_per_share"
    t.float "debt_to_equity"
    t.float "gearing_ratio"
    t.float "gross_margin"
    t.float "operating_margin"
    t.float "net_margin"
    t.float "return_on_asset"
    t.float "return_on_equity"
    t.float "net_debt_to_ebitda"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "indexes", id: :integer, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issuers", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_price", default: 0
    t.bigint "current_market_capitalization"
    t.float "current_price_earning_ratio"
    t.float "current_price_to_book_value_ratio"
  end

  create_table "stock_prices", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "issuer_id"
    t.date "date"
    t.integer "open"
    t.integer "high"
    t.integer "low"
    t.integer "close"
    t.bigint "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "foreign_sell", default: 0
    t.bigint "foreign_buy", default: 0
    t.bigint "bid_volume"
    t.bigint "offer_volume"
    t.integer "frequency"
    t.index ["date"], name: "date"
    t.index ["issuer_id"], name: "issuer_id"
  end

end

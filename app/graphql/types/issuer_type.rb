require_relative 'price_type'

module Types
  class Issuer < GraphQL::Schema::Object
    field :id, ID, null: false
    field :code, String, null: false
    field :name, String, null: false
    field :current_price, Integer, null: true
    field :current_market_capitalization, Integer, null: true
    field :current_price_earning_ratio, Float, null: true
    field :current_price_to_book_value_ratio, Float, null: true
    field :stock_prices, [Types::Price], null: true
  end
end
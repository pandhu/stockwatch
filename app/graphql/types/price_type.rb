module Types
  class Price < GraphQL::Schema::Object
    field :date, String, null: false
    field :open, Integer, null: false
    field :high, Integer, null: false
    field :low, Integer, null: false
    field :close, Integer, null: false
    field :volume, Integer, null: false
    field :foreign_buy, Integer, null: false
    field :foreign_sell, Integer, null: false
    field :frequency, Integer, null: false
    field :bid_volume, Integer, null: false
    field :offer_volume, Integer, null: false
  end
end
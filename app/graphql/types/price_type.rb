module Types
  class Price < GraphQL::Schema::Object
    field :date, String, null: false
    field :open, Integer, null: false
    field :high, Integer, null: false
    field :low, Integer, null: false
    field :close, Integer, null: false
    field :volume, Integer, null: false
  end
end
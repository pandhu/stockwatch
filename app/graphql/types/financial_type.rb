module Types
  class Financial < GraphQL::Schema::Object
    field :issuer_id, Integer, null: false
    field :year, Integer, null: false
    field :period, Integer, null: false
    field :currency, String, null: true
    field :outstanding_shares, Integer, null: true
    field :market_capitalization, Integer, null: true
    field :assets, Integer, null: true
    field :liabilities, Integer, null: true
    field :equity, Integer, null: true
    field :net_debt, Integer, null: true
    field :sales, Integer, null: true
    field :gross_profit, Integer, null: true
    field :operating_profit, Integer, null: true
    field :ebitda, Integer, null: true
    field :net_profit, Integer, null: true
    field :operating_cash_flow, Integer, null: true
    field :free_cash_flow, Integer, null: true
    field :price_earning_ratio, Float, null: true
    field :price_to_book_value_ratio, Float, null: true
    field :book_value_per_share, Float, null: true
    field :earning_per_share, Float, null: true
    field :debt_to_equity, Float, null: true
    field :gearing_ratio, Float, null: true
    field :gross_margin, Float, null: true
    field :operating_margin, Float, null: true
    field :net_margin, Float, null: true
    field :return_on_asset, Float, null: true
    field :return_on_equity, Float, null: true
    field :net_debt_to_ebitda, Float, null: true
  end
end
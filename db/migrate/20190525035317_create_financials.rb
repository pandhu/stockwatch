class CreateFinancials < ActiveRecord::Migration[5.2]
  def change
    create_table(:financials, id: :bigint, unsigned: true, options: 'DEFAULT CHARSET=utf8') do |t|
      t.integer    :issuer_id
      t.integer    :year
      t.integer    :period
      t.string     :currency
      t.bigint     :outstanding_shares
      t.bigint     :market_capitalization
      t.bigint     :assets
      t.bigint     :liabilities
      t.bigint     :equity
      t.bigint     :net_debt
      t.bigint     :sales
      t.bigint     :gross_profit
      t.bigint     :operating_profit
      t.bigint     :ebitda
      t.bigint     :net_profit
      t.bigint     :operating_cash_flow
      t.bigint     :free_cash_flow
      t.float      :price_earning_ratio
      t.float      :price_to_book_value_ratio
      t.float      :book_value_per_share
      t.float      :earning_per_share
      t.float      :debt_to_equity
      t.float      :gearing_ratio
      t.float      :gross_margin
      t.float      :operating_margin
      t.float      :net_margin
      t.float      :return_on_asset
      t.float      :return_on_equity
      t.float      :net_debt_to_ebitda
      t.timestamps
    end
  end
end

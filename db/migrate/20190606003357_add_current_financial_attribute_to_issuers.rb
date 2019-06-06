class AddCurrentFinancialAttributeToIssuers < ActiveRecord::Migration[5.2]
  def up
    add_column :issuers, :current_price, :integer, default: 0
    add_column :issuers, :current_market_capitalization, :bigint
    add_column :issuers, :current_price_earning_ratio, :float
    add_column :issuers, :current_price_to_book_value_ratio, :float
  end

  def down
    remove_column :issuers, :current_price, :integer, default: 0
    remove_column :issuers, :current_market_capitalization, :bigint
    remove_column :issuers, :current_price_earning_ratio, :float
    remove_column :issuers, :current_price_to_book_value_ratio, :float  end
end

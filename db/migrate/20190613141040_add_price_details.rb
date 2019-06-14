class AddPriceDetails < ActiveRecord::Migration[5.2]
  def up
    add_column :stock_prices, :foreign_sell, :bigint, default: 0
    add_column :stock_prices, :foreign_buy, :bigint, default: 0
    add_column :stock_prices, :bid_volume, :bigint
    add_column :stock_prices, :offer_volume, :bigint
    add_column :stock_prices, :frequency, :integer

  end

  def down
    remove_column :stock_prices, :foreign_sell
    remove_column :stock_prices, :foreign_buy
    remove_column :stock_prices, :bid_volume
    remove_column :stock_prices, :offer_volume
    remove_column :stock_prices, :frequency
  end
end

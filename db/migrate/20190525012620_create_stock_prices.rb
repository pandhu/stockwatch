class CreateStockPrices < ActiveRecord::Migration[5.2]
  def change
    create_table(:stock_prices, id: :bigint, unsigned: true, options: 'DEFAULT CHARSET=utf8') do |t|
      t.bigint     :issuer_id
      t.date       :date
      t.integer    :open
      t.integer    :high
      t.integer    :low
      t.integer    :close
      t.bigint     :volume
      t.timestamps
    end
  end
end

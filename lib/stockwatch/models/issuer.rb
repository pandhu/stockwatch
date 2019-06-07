module Stockwatch
  class Issuer < ActiveRecord::Base
    has_many :financials
    has_many :stock_prices

    def last_price
      self.stock_prices.order(:date).last
    end

    def last_period_financial_report
      self.financials.order(:year, :period).last
    end

    def cumulative_earning(number_of_periods)
      financials = self.financials.order(:year, :period).last(4)
      earnings = 0
      financials.each do | financial |
        earnings += financial.net_profit
      end
      earnings
    end
  end
end

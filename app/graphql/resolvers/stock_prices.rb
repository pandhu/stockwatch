require_relative '../types/price_type'

module Resolvers
  class StockPrices < Resolvers::Base
    type [Types::Price], null: false

    argument :order_by, String, required: false
    argument :direction, String, required: false

    def resolve(order_by: nil, direction: 'ASC')
      if(order_by.nil?)
        Stockwatch::StockPrice.where(issuer_id: @object.id).order("date")
      else
        Stockwatch::StockPrice.where(issuer_id: @object.id).order("#{order_by} #{direction}")
      end
    end
  end
end
require_relative '../types/financial_type'

module Resolvers
  class Financials < Resolvers::Base
    type [Types::Financial], null: false

    argument :order_by, String, required: false
    argument :direction, String, required: false

    def resolve(order_by: nil, direction: 'ASC')
      if(order_by.nil?)
        Stockwatch::Financial.where(issuer_id: @object.id).order(:year, :period)
      else
        Stockwatch::Financial.where(issuer_id: @object.id).order("#{order_by} #{direction}")
      end
    end
  end
end
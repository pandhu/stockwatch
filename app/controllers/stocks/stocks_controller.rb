module Stocks
  class StocksController < ApplicationController
    get '/' do
      status 200
      'ok'
    end
  end
end

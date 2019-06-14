module Services
  class PriceDataFetch

    FETCH_URL = ENV['PRICE_DATA_FETCH_URL'].freeze

    def initialize(date)
      @date = date
    end

    def perform
      price_data = fetch_price_data
    end

    def perform_helper(issuers)
      issuers.each do | issuer |
        begin
          p issuer.code
          fetch_price_data(issuer)
        rescue => e
          p "#{issuer.code} #{e} #{e.backtrace}"
          retry
        end
      end
    end

    def fetch_price_data
      url = "#{FETCH_URL}&date=#{@date.strftime('%Y%m%d')}"
      response = Connection.get(url, nil)
      results  = JSON.parse(response.body).dig("data")

      results.each do | input |
        issuer = Stockwatch::Issuer.find_by(code: input.dig("StockCode"))
        if issuer.nil?
          next
        end
        stock_price = Stockwatch::StockPrice.find_by(issuer_id: issuer.id, date: @date)
        save_price_data(issuer, input) if stock_price.nil?
      end
    end

    def save_price_data(issuer, data)
      p "#{@date.strftime('%Y%m%d')} - #{issuer.code}"
      stock_price = Stockwatch::StockPrice.new
      stock_price.issuer_id      = issuer.id
      stock_price.date           = data["Date"]
      stock_price.open           = data["OpenPrice"]
      stock_price.close          = data["Close"]
      stock_price.low            = data["Low"]
      stock_price.high           = data["High"]
      stock_price.volume         = data["Volume"]
      stock_price.foreign_buy    = data["ForeignBuy"]
      stock_price.foreign_sell   = data["ForeignSell"]
      stock_price.bid_volume     = data["BidVolume"]
      stock_price.offer_volume   = data["OfferVolume"]
      stock_price.frequency      = data["Frequency"]

      stock_price.save!
    end
  end
end
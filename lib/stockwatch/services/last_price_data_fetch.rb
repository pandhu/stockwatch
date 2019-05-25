module Services
  class LastPriceDataFetch

    FETCH_URL = ENV['PRICE_DATA_FETCH_URL'].freeze
    DATE = 0
    OPEN = 1
    HIGH = 2
    LOW = 3
    CLOSE = 4
    VOLUME = 5

    def perform
      issuers = Stockwatch::Issuer.all
      perform_helper(issuers)
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

    def fetch_price_data(issuer)
      url = "#{FETCH_URL}&stockCode=#{issuer.code}"
      response = Connection.get(url, nil)
      binding.pry
      results  = response.body.split("\n")
      last_entry = results.last
      input = JSON.parse(last_entry)
      data = input.dig("data")
      stock_price = Stockwatch::StockPrice.find_by(issuer_id: issuer.id, date: data[DATE])
      save_price_data(issuer, data) if stock_price.nil?
    end

    def save_price_data(issuer, data)
      stock_price = Stockwatch::StockPrice.new
      stock_price.issuer_id = issuer.id
      stock_price.date      = data[DATE]
      stock_price.open      = data[OPEN]
      stock_price.close     = data[CLOSE]
      stock_price.low       = data[LOW]
      stock_price.high      = data[HIGH]
      stock_price.volume    = data[VOLUME]
      stock_price.save!
    end
  end
end
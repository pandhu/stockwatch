module Services
  class SyncCurrentMetrics
    def initialize(issuers_code = [])
      @issuers_code = issuers_code
    end

    def perform
      issuers = @issuers_code.empty? ? Stockwatch::Issuer.all : Stockwatch::Issuer.where(:code => @issuers_code)
      issuers.each do | issuer |
        begin
          sync_current_metrics(issuer)
        rescue => e
          p "#{issuer.code} failed to Sync : #{e}"
        end
      end
    end

    private

    def sync_current_metrics(issuer)
      p "Sync #{issuer.code}"
      last_price = issuer.last_price
      last_market_capitalization = calculate_market_capitalization(issuer, last_price)
      last_price_earning_ratio = calculate_price_earning_ratio(issuer, last_price).round(3)
      last_price_to_book_value_ratio = calculate_price_to_book_value_ratio(issuer, last_price).round(3)

      issuer.current_price = last_price.close
      issuer.current_market_capitalization = last_market_capitalization
      issuer.current_price_earning_ratio = last_price_earning_ratio
      issuer.current_price_to_book_value_ratio = last_price_to_book_value_ratio
      issuer.save!
      p "#{issuer.code} Sync-ed"
    end

    def calculate_market_capitalization(issuer, price)
      last_financial_report = issuer.last_period_financial_report
      last_financial_report.outstanding_shares * price.close
    end

    def calculate_price_earning_ratio(issuer, price)
      number_of_periods = 4
      calculate_market_capitalization(issuer, price).to_f / (issuer.cumulative_earning(number_of_periods) * 1_000_000)
    end

    def calculate_price_to_book_value_ratio(issuer, price)
      last_financial_report = issuer.last_period_financial_report
      calculate_market_capitalization(issuer, price).to_f / ((last_financial_report.assets - last_financial_report.liabilities) * 1_000_000)
    end
  end
end
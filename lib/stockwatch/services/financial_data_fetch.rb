require 'bigdecimal'
module Services
  class FinancialDataFetch

    FETCH_URL = ENV['FINANCIAL_DATA_FETCH_URL'].freeze
    PERIODS = ['3m', '6m', '9m', '12m']
    #PERIODS = ['3m']

    def initialize(issuer_code = nil)
      @issuer_code = issuer_code
    end

    def perform
      if @issuer_code.nil?
        issuers = Stockwatch::Issuer.all
      else
        issuers = Stockwatch::Issuer.where(code: @code)
      end

      issuers.each do | issuer |
        PERIODS.each do | period |
          begin
            fetch_financial_data(issuer, period)
          rescue => e
            p "ERROR #{issuer.code} #{period} #{e}"
            p e.backtrace[4]
          end
        end
      end
    end

    def fetch_financial_data(issuer, period)
      p "fetch financial data #{issuer.code} #{period}"
      try_count = 0
      begin
        try_count += 1
        response = Connection.get("#{FETCH_URL}#{period}/#{issuer.code}", nil)
        result   = JSON.parse(response)
        financial_data = result.dig('finance')
        financial_data.each do | data |
          save_financial(issuer, data, result.dig('currency'))
        end
      rescue => e
        p response
        retry if try_count < 3
      end
    end

    def save_financial(issuer, data, currency)
      period = data.dig('period').split('|')
      data = data.dig('data')
      financial = Stockwatch::Financial.find_by(issuer_id: issuer.id, year: period[0], period: period[1])
      return if data.nil?

      financial.issuer_id                   = issuer.id
      financial.currency                    = currency
      financial.year                        = period[0]
      financial.period                      = period[1]
      financial.outstanding_shares          = data["EQY_SH_OUT"].to_f * 1_000_000
      financial.market_capitalization       = BigDecimal.new(data["HISTORICAL_MARKET_CAP"]).to_i
      financial.assets                      = BigDecimal.new(data["BS_TOT_ASSET"]).to_i
      financial.liabilities                 = BigDecimal.new(data["BS_TOT_LIAB2"]).to_i
      financial.equity                      = BigDecimal.new(data["TOTAL_EQUITY"]).to_i
      financial.net_debt                    = data["NET_DEBT"].to_i
      financial.sales                       = BigDecimal.new(data["SALES_REV_TURN"]).to_i
      financial.gross_profit                = data["GROSS_PROFIT"].to_i
      financial.operating_profit            = data["IS_OPER_INC"].to_i
      financial.ebitda                      = data["EBITDA"].to_i
      financial.net_profit                  = data["NET_INCOME"].to_i
      financial.operating_cash_flow         = data["CF_CASH_FROM_OPER"].to_i
      financial.free_cash_flow              = data["CF_FREE_CASH_FLOW"].to_i
      financial.book_value_per_share        = data["BOOK_VAL_PER_SH"].to_f
      financial.earning_per_share           = data["IS_EPS"].to_f
      financial.debt_to_equity              = data["TOT_DEBT_TO_TOT_EQY"].to_f
      financial.gearing_ratio               = data["NET_DEBT_TO_SHRHLDR_EQTY"].to_f
      financial.price_earning_ratio         = data["PE_RATIO"].to_f
      financial.price_to_book_value_ratio   = data["PX_TO_BOOK_RATIO"].to_f
      financial.gross_margin                = data["GROSS_MARGIN"].to_f
      financial.operating_margin            = data["OPER_MARGIN"].to_f
      financial.net_margin                  = data["PROF_MARGIN"].to_f
      financial.return_on_asset             = data["RETURN_ON_ASSET"].to_f
      financial.return_on_equity            = data["RETURN_COM_EQY"].to_f
      financial.net_debt_to_ebitda          = data["NET_DEBT_TO_EBITDA"].to_f

      financial.save!
    end
  end
end

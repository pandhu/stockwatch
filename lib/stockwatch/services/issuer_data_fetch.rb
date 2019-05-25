module Services
  class IssuerDataFetch

    FETCH_URL = ENV['ISSUER_DATA_FETCH_URL'].freeze

    def perform
      response = Connection.get(FETCH_URL, nil)
      result   = JSON.parse(response)
      save_issuers(result)
    end

    def save_issuers(result)
      result.each do |input|
        issuer = Stockwatch::Issuer.find_by(code: input["KodeEmiten"])
        save_issuer(input) if issuer.nil?
      end
    end

    def save_issuer(input)
      issuer = Stockwatch::Issuer.new
      issuer.code = input["KodeEmiten"]
      issuer.name = input["NamaEmiten"]
      issuer.save!
    end
  end
end
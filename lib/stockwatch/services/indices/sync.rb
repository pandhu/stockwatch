module Services
  module Indices
    class Sync
      def perform
        indices = Stockwatch::Index.all
        indices.each do | index |
          sync_index(index)
        end
      end

      private

      def sync_index(index)
        issuer_codes = get_issuers(index.code)
        Stockwatch::IssuerIndex.where(index_id: index.id).delete_all
        issuer_codes.each do | issuer_code |
          begin
            issuer = Stockwatch::Issuer.find_by_code(issuer_code)
            issuer_index = Stockwatch::IssuerIndex.new
            issuer_index.issuer_id = issuer.id
            issuer_index.index_id = index.id
            issuer_index.save!
          rescue => e
            p "error add #{issuer_code}"
            raise e
          end
        end
      end

      def get_issuers(index_code)
        file = File.open("./indices/#{index_code}")
        file_data = file.readlines.map(&:chomp)
        file_data
      end
    end
  end
end

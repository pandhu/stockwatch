class QueryRoot  < GraphQL::Schema::Object
  description "The query root of this schema"

  field :issuers, [Types::Issuer], null: false do
    description 'Get all issuers'
    argument :code, String, required: false
  end

  field :issuer, [Types::Issuer], null: false do
    description 'Get issuers given code'
    argument :code, String, required: false
  end

  def issuers
    Stockwatch::Issuer.all
  end

  def issuer(code:)
    Stockwatch::Issuer.where(code: code)
  end
end
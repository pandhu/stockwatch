class GraphqlController < ApplicationController
  use Rack::PostBodyContentTypeParser

  post '/' do
    result = Schemas.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    JSON result
  end
end

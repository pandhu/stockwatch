require 'sinatra/cross_origin'

class GraphqlController < ApplicationController
  use Rack::PostBodyContentTypeParser
  register Sinatra::CrossOrigin

  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    200
  end

  post '/' do
    cross_origin
    result = Schemas.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    JSON result
  end
end

require './main'

ActiveRecord::Base.connection
before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

map('/healthz') { run HealthzController }
map('/graphql') { run GraphqlController }

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end
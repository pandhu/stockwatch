require './main'

ActiveRecord::Base.connection

map('/healthz') { run HealthzController }
map('/graphql') { run GraphqlController }
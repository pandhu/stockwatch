class HealthzController < ApplicationController
  get '/' do
    status 200
    'ok'
  end
end

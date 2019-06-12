require 'dotenv'
require 'bundler'
require 'sinatra/cross_origin'
require 'base64'
require 'cgi'
require 'openssl'
require 'require_all'
require 'graphql'
require 'rack/contrib'

Dotenv.load

ENV['RACK_ENV'] ||= 'development'

Bundler.require(:default, ENV['RACK_ENV'])
# loader class
class Main < Sinatra::Base
  set :root, File.dirname(__FILE__)

  configure ENV['RACK_ENV'].to_sym do
    set    :server, :puma
    set    :database_file, root + '/config/database.yml'
    enable :raise_errors, :sessions, :logging
  end

  require_all './config/initializer/*.rb'
  require_all './lib/stockwatch/errors.rb'
  require_all './lib/stockwatch/models/*.rb'
  require_all './app/utilities/**/*.rb'
  require_all './lib/**/*.rb'
  require_all './app/graphql/types/*.rb'
  require_all './app/graphql/*.rb'
  require_all './app/controllers/**/*.rb'
end

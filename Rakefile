# encoding: UTF-8

require 'bundler'
require './main'
require 'sinatra/activerecord/rake'

desc 'Default: run specs' # & rubocop'
task test: [:spec] # :rubocop]

desc 'Run specs'
begin
  require 'rspec/core/rake_task'
  require 'pry'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = '--require ./spec/spec_helper'
  end
  Pry.config.input = STDIN
  Pry.config.output = STDOUT
rescue LoadError, NameError
end

namespace :issuers do
  task :fetch do
    retry_count = 0
    begin
      response = Services::IssuerDataFetch.new.perform
    rescue => e
      p e.backtrace
      retry_count += 1
      sleep(10)
      retry if retry_count < 2
    end
  end

  task :sync_metrics do
    retry_count = 0
    begin
      response = Services::SyncCurrentMetrics.new.perform
    rescue => e
      p e
      p e.backtrace
      retry_count += 1
      sleep(3)
      retry if retry_count < 2
    end
  end
end

namespace :financials do
  task :fetch do
    retry_count = 0
    begin
      response = Services::FinancialDataFetch.new.perform
    rescue => e
      p e
      p e.backtrace
      retry_count += 1
      sleep(3)
      retry if retry_count < 2
    end
  end
end

namespace :prices do
  task :fetch, [:date_range] do |task, args|
    retry_count = 0
    begin
      if args.dig(:date_range).nil?
        start_date = Date.today
        end_date = Date.today
      else
        start_date = Date.parse(args[:date_range].split(' ')[0])
        end_date = Date.parse(args[:date_range].split(' ')[1])
      end

      start_date.upto(end_date) do |date|
        response = Services::PriceDataFetch.new(date).perform
      end
    rescue => e
      p e
      p e.backtrace
      retry_count += 1
      sleep(3)
      retry if retry_count < 2
    end
  end
end

namespace :lastprice do
  task :fetch do
    retry_count = 0
    begin
      response = Services::LastPriceDataFetch.new.perform
    rescue => e
      p e
      p e.backtrace
      retry_count += 1
      sleep(3)
      retry if retry_count < 2
    end
  end
end

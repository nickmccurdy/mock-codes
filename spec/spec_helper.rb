require 'simplecov'
SimpleCov.start

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rspec'
require 'rack/test'

set :environment, :test

def app
  MockIssues
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def each_code(codes = YAML::load_file(File.join(__dir__, '..', 'codes.yml')), &block)
  codes.each(&block)
end

def each_verb(url, verbs = %w(get post put delete options patch))
  verbs.each do |verb|
    send(verb, url)
    yield
  end
end

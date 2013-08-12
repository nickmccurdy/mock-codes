require 'bundler'
Bundler.require

require 'yaml'

def any(url, verbs = %w(get post put delete options patch), &block)
  verbs.each do |verb|
    send(verb, url, &block)
  end
end

class MockIssues < Sinatra::Base
  codes = YAML::load_file('codes.yml')

  # Read ENV variables for hesitate and timeout
  hesitateTime = ENV['MOCK_HESITATE'] || 2
  timeoutTime = ENV['MOCK_TIMEOUT'] || 2

  get '/' do
    @codes = codes
    
    erb :index
  end

  any '/hesitate' do
    sleep hesitateTime

    body "#{hesitateTime} seconds later..."
  end

  any '/timeout' do
    sleep timeoutTime
    body "#{timeoutTime} seconds later..."
  end

  any '/:code' do
    code = params[:code].to_i
    message = codes[code]

    if message.nil?
      code = 404
      message = codes[code]
    end

    body message
    halt code
  end
end

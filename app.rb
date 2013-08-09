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

  get '/' do
    @codes = codes
    
    erb :index
  end

  any '/hesitate' do
    sleep 5

    body "5 seconds later..."
  end

  any '/timeout' do
    sleep 28
    body "28 seconds later..."
  end

  any '/:code' do
    code = params[:code].to_i
    message = codes[code]

    if message.nil?
      code = '404'
      message = codes[code]
    end

    body message
    halt code.to_i
  end
end

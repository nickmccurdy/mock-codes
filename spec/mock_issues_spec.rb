require 'spec_helper'

describe MockIssues do
  @codes = YAML::load_file(File.join(__dir__, '..', 'codes.yml'))

  it 'should load the home page' do
    get '/'
    last_response.should be_ok
  end

  @codes.each do |code, text|
    it "should respond with #{code} (#{text})" do
      get "/#{code}"
      last_response.status.should == code
      expected_body = (code == 304) ? '' : text
      last_response.body.should == expected_body
    end
  end

  it 'should respond with 200 (Successful) after hesitating' do
    # 5 second delay
    get '/hesitate'
    last_response.should be_ok
    last_response.body.should == '5 seconds later...'
  end

  it 'should respond with 200 (Successful) after timing out' do
    # 28 second delay
    get '/timeout'
    last_response.should be_ok
    last_response.body.should == '28 seconds later...'
  end

  it 'should respond with 404 (Not Found) when a page does not exist' do
    get '/not_a_valid_status_code'
    last_response.status.should == 404
    last_response.body.should == 'Not Found'
  end
end

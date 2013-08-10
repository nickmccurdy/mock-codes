require 'spec_helper'

describe MockIssues do
  it 'loads the home page' do
    get '/'
    last_response.should be_ok
  end

  CODES.each do |code, text|
    it "responds with #{code} (#{text})" do
      each_verb "/#{code}" do
        last_response.status.should == code
        expected_body = (code == 304) ? '' : text
        last_response.body.should == expected_body
      end
    end
  end

  it 'responds with 200 (Successful) after hesitating' do
    # 5 second delay
    each_verb '/hesitate' do
      last_response.should be_ok
      last_response.body.should == '5 seconds later...'
    end
  end

  it 'responds with 200 (Successful) after timing out' do
    # 28 second delay
    each_verb '/timeout' do
      last_response.should be_ok
      last_response.body.should == '28 seconds later...'
    end
  end

  it 'responds with 404 (Not Found) when a page does not exist' do
    each_verb '/not_a_valid_status_code' do
      last_response.status.should == 404
      last_response.body.should == 'Not Found'
    end
  end
end

require 'spec_helper'

describe MockIssues do
  it 'loads the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  each_code do |code, text|
    it "responds with #{code} (#{text})" do
      each_verb "/#{code}" do
        expect(last_response.status).to eq code
        expected_body = (code == 304) ? '' : text
        expect(last_response.body).to eq expected_body
      end
    end
  end

  it 'responds with 200 (Successful) after hesitating' do
    # 5 second delay
    each_verb '/hesitate' do
      expect(last_response).to be_ok
      expect(last_response.body).to eq '5 seconds later...'
    end
  end

  it 'responds with 200 (Successful) after timing out' do
    # 28 second delay
    each_verb '/timeout' do
      expect(last_response).to be_ok
      expect(last_response.body).to eq '28 seconds later...'
    end
  end

  it 'responds with 404 (Not Found) when a page does not exist' do
    each_verb '/not_a_valid_status_code' do
      expect(last_response.status).to eq 404
      expect(last_response.body).to eq 'Not Found'
    end
  end
end

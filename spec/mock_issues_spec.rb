require 'spec_helper'

describe MockIssues do
  it 'should load the home page' do
    get '/'
    last_response.should be_ok
  end
end

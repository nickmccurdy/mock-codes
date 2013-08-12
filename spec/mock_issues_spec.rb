require 'spec_helper'

describe MockIssues do
  describe 'home page' do
    it 'loads succesfully' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe 'status page' do
    context 'for numerical codes' do
      each_code do |code, text|
        it "responds with #{code} (#{text})" do
          each_verb "/#{code}" do
            expect(last_response.status).to eq code
            expected_body = (code == 304) ? '' : text
            expect(last_response.body).to eq expected_body
          end
        end
      end
    end

    context 'for time delays' do
      context 'after hesitating' do
        it 'responds with 200 (Successful)' do
          # 5 second delay
          each_verb '/hesitate' do
            expect(last_response).to be_ok
            expect(last_response.body).to eq '5 seconds later...'
          end
        end
      end

      context 'after timing out' do
        it 'responds with 200 (Successful)' do
          # 28 second delay
          each_verb '/timeout' do
            expect(last_response).to be_ok
            expect(last_response.body).to eq '28 seconds later...'
          end
        end
      end
    end
  end

  describe '404 (Not Found) page' do
    it 'displays when a page does not exist' do
      each_verb '/not_a_valid_status_code' do
        expect(last_response.status).to eq 404
        expect(last_response.body).to eq 'Not Found'
      end
    end
  end
end

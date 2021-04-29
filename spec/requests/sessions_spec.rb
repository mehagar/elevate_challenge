require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'sign_in' do
    context 'valid credentials' do
      it 'returns a token when c' do
        json_params = { email: 'test_email', username: 'test_user', fullname: 'first last',
                        password: 'testpassword' }.to_json

        post '/api/sessions', params: json_params, headers: json_request_headers

        expect(json[:token]).to_not be_nil
      end
    end

    context 'invalid credentials' do
      it 'does not return token' do
      end
    end
  end
end

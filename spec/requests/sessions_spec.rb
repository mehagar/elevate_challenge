require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'sign_in' do
    context 'valid credentials' do
      it 'returns a valid token' do
        attrs = { email: 'test_email', username: 'test_user', fullname: 'first last',
                  password: 'testpassword' }
        User.create(attrs)
        json_params = attrs.to_json

        post '/api/sessions', params: json_params, headers: json_request_headers

        expect(json[:token]).to_not be_nil
      end
    end

    context 'invalid credentials' do
      it 'does not return token' do
        attrs = { email: 'test_email', username: 'test_user', fullname: 'first last',
                  password: 'testpassword' }
        User.create(attrs)
        attrs[:password] = 'wrongpassword'
        json_params = attrs.to_json

        post '/api/sessions', params: json_params, headers: json_request_headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

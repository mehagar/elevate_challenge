require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  it 'allows signing up' do
    json_params = { email: 'test_email', username: 'test_user', full_name: 'first last', password: 'testpassword' }.to_json
    post '/api/users/sign_up', params: json_params, headers: headers

    expect(response).to have_http_status(:created)
  end
end

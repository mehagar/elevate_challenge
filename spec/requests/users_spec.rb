require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  it 'allows signing up' do
    json_params = { email: 'test_email', username: 'test_user', fullname: 'first last', password: 'testpassword' }.to_json

    post '/api/user', params: json_params, headers: json_request_headers

    expect(response).to have_http_status(:created)
    expect(User.find_by(email: 'test_email')).to_not be_nil
  end
end

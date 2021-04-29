require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  it 'allows signing up' do
    json_params = { email: 'test_email', username: 'test_user', fullname: 'first last', password: 'testpassword' }.to_json

    post '/api/users/sign_up', params: json_params, headers: headers

    expect(response).to have_http_status(:created)
    expect(User.find_by(email: 'test_email')).to_not be_nil
  end
end

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  before do
    @current_user = User.create(email: 'test@email.com',
                                username: 'test_user',
                                fullname: 'test_name',
                                password: 'test_password',
                                auth_token: '12345')
  end

  it 'allows signing up' do
    json_params = { email: 'test_email', username: 'test_user', fullname: 'first last',
                    password: 'testpassword' }.to_json

    post '/api/user', params: json_params, headers: json_request_headers

    expect(response).to have_http_status(:created)
    expect(User.find_by(email: 'test_email')).to_not be_nil
  end

  it 'creates game events' do
    game = Game.create(name: 'game1', url: 'http://game1', category: 'math')
    json_params = { game_event: { type: 'COMPLETED', occured_at: DateTime.now.to_i, game_id: game.id } }.to_json

    expect { post '/api/user/game_events', params: json_params, headers: json_request_headers(@current_user.auth_token) }.to change { GameEvent.count }.by(1)

    expect(response).to have_http_status(:created)
  end
end

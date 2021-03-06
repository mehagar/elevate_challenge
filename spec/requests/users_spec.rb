require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  before do
    @current_user = User.create(email: 'test@email.com',
                                username: 'test_user',
                                fullname: 'test_name',
                                password: 'test_password',
                                auth_token: '12345')
  end

  describe 'post /api/user' do
    it 'allows signing up' do
      json_params = { email: 'test_email', username: 'test_user', fullname: 'first last',
                      password: 'testpassword' }.to_json

      post '/api/user', params: json_params, headers: json_request_headers

      expect(response).to have_http_status(:created)
      expect(User.find_by(email: 'test_email')).to_not be_nil
    end
  end

  describe 'post api/user/game_events' do
    it 'creates game events' do
      game = Game.create(name: 'game1', url: 'http://game1', category: 'math')
      json_params = { game_event: { type: 'COMPLETED', occured_at: DateTime.now.to_i, game_id: game.id } }.to_json

      expect { post '/api/user/game_events', params: json_params, headers: json_request_headers(@current_user.auth_token) }.to change { GameEvent.count }.by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'get api/user' do
    before do
      @math_game = Game.create(name: 'math_game', url: 'http://math', category: 'math')
      @reading_game = Game.create(name: 'reading_game', url: 'http://reading_game', category: 'reading')
    end

    it 'gets the current users details' do
      num_math_game_events = 4
      num_math_game_events.times do
        GameEvent.create!(game_type: 'COMPLETED',
                          occured_at: Date.today,
                          game_id: @math_game.id,
                          user_id: @current_user.id)
      end

      num_reading_game_events = 4
      num_reading_game_events.times do
        GameEvent.create!(game_type: 'COMPLETED',
                          occured_at: Date.today,
                          game_id: @reading_game.id,
                          user_id: @current_user.id)
      end

      get '/api/user', headers: json_request_headers(@current_user.auth_token)

      expect(json[:user][:id]).to eq(@current_user.id)
      expect(json[:user][:stats][:total_games_played]).to eq(num_math_game_events + num_reading_game_events)
      expect(json[:user][:stats][:total_math_games_played]).to eq(num_math_game_events)
      expect(json[:user][:stats][:total_reading_games_played]).to eq(num_reading_game_events)
    end

    context 'played today' do
      it 'shows streak > 1 day when played on current day' do
        # create game events on consecutive days for single game
        current_day = Date.today
        travel_to(current_day) do
          GameEvent.create!(game_type: 'COMPLETED',
                            occured_at: current_day,
                            game_id: @math_game.id,
                            user_id: @current_user.id)

          GameEvent.create!(game_type: 'COMPLETED',
                            occured_at: current_day.prev_day(1),
                            game_id: @math_game.id,
                            user_id: @current_user.id)

          GameEvent.create!(game_type: 'COMPLETED',
                            occured_at: current_day.prev_day(2),
                            game_id: @math_game.id,
                            user_id: @current_user.id)

          get '/api/user', headers: json_request_headers(@current_user.auth_token)

          expect(json[:user][:stats][:current_streak_in_days]).to eq(3)
        end
      end
    end

    context 'did not play today' do
      it 'shows 0 streak' do
        travel_to(Date.today.next_day(2)) do
          get '/api/user', headers: json_request_headers(@current_user.auth_token)

          expect(json[:user][:stats][:current_streak_in_days]).to eq(0)
        end
      end

      it 'shows streak if played yesterday but not today' do
        current_day = Date.today
        travel_to(current_day) do
          GameEvent.create!(game_type: 'COMPLETED',
                            occured_at: current_day.prev_day(1),
                            game_id: @math_game.id,
                            user_id: @current_user.id)

          GameEvent.create!(game_type: 'COMPLETED',
                            occured_at: current_day.prev_day(2),
                            game_id: @math_game.id,
                            user_id: @current_user.id)

          get '/api/user', headers: json_request_headers(@current_user.auth_token)

          expect(json[:user][:stats][:current_streak_in_days]).to eq(2)
        end
      end
    end
  end
end

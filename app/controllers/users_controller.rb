class UsersController < ApplicationController
  def sign_up
    User.create!(user_params)

    head :created
  end

  def create_game_event
    # under game_event key, type, occured_at, game_id. Type field will always be COMPLETED game id will be valid game.
    # game_event_params
    # what to do with event?
    # want to record number of games played per user, along with each type of game. game event model references game_id and user_id, so
    # can select COUNT(*) from users join game_events on user.id = game_events.id to get total number of games played
    # select COUNT(*) from users join game_events on user.id = game_events.id join games on game_events.id = games.id group by games.category
    head :ok
  end

  def user_params
    params.permit(:email, :username, :fullname, :password)
  end

  def game_event_params
    params.require(:game_event).permit(:type, :occured_at, :game_id)
  end
end

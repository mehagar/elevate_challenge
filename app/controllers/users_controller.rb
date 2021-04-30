class UsersController < ApplicationController
  def sign_up
    User.create!(user_params)

    head :created
  end

  def create_game_event
    GameEvent.create!(game_type: game_event_params[:type],
                      occured_at: game_event_params[:occured_at],
                      game_id: game_event_params[:game_id],
                      user_id: current_user.id)

    head :created

    # want to record number of games played per user, along with each type of game. game event model references game_id and user_id, so
    # can select COUNT(*) from users join game_events on user.id = game_events.id to get total number of games played
    # select COUNT(*) from users join game_events on user.id = game_events.id join games on game_events.id = games.id group by games.category
  end

  def user_params
    params.permit(:email, :username, :fullname, :password)
  end

  def game_event_params
    params.require(:game_event).permit(:type, :occured_at, :game_id)
  end
end

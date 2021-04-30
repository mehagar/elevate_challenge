class UsersController < ApplicationController
  def sign_up
    User.create!(user_params)

    head :created
  end

  def details
    user = current_user

    user_stats = {}
    Game::GAME_CATEGORIES.each do |category|
      # TODO: is this n+1?
      games_played_in_category = user.game_events.where { |game_event| game_event.game.category == category }
      user_stats["total_#{category}_games_played".to_sym] = games_played_in_category
    end

    user_details = {
      user: {
        id: User.id,
        username: user.username,
        email: user.email,
        full_name: user.fullname,
        stats: user_stats }
    }.to_json

    render :json, user_details
  end

  def create_game_event
    GameEvent.create!(game_type: game_event_params[:type],
                      occured_at: game_event_params[:occured_at],
                      game_id: game_event_params[:game_id],
                      user_id: current_user.id)

    head :created
  end

  def user_params
    params.permit(:email, :username, :fullname, :password)
  end

  def game_event_params
    params.require(:game_event).permit(:type, :occured_at, :game_id)
  end
end

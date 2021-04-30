class UsersController < ApplicationController
  def sign_up
    User.create!(user_params)

    head :created
  end

  def details
    user = current_user

    user_stats = get_user_stats(user)

    user_details = {
      id: user.id,
      username: user.username,
      email: user.email,
      full_name: user.fullname,
      stats: user_stats
    }

    render json: { user: user_details }
  end

  def create_game_event
    # convert occured_at to date if it's an integer
    date_event_occured = Date.new(game_event_params[:occured_at])
    GameEvent.create!(game_type: game_event_params[:type],
                      occured_at: date_event_occured,
                      game_id: game_event_params[:game_id],
                      user_id: current_user.id)

    head :created
  end

  private

  def get_user_stats(user)
    user_stats = {}
    total_games_played = 0
    Game::GAME_CATEGORIES.each do |category|
      games_played_in_category = user.game_events.includes(:game).count { |game_event| is_completed_game?(game_event, category) }
      total_games_played += games_played_in_category
      user_stats["total_#{category}_games_played".to_sym] = games_played_in_category
    end

    user_stats[:total_games_played] = total_games_played
    user_stats[:current_streak_in_days] = get_current_streak(user)
    user_stats
  end

  def get_current_streak(user)
    streak = 0
    current_day = Date.yesterday
    loop do
      break unless user.game_events.where(occured_at: current_day).count.positive?

      streak += 1
      current_day = current_day.prev_day
    end

    # there can still be a streak even if the current day does not have a game event,
    # so handle that case here.
    streak += 1 if user.game_events.where(occured_at: Date.today).count.positive?
    streak
  end

  def is_completed_game?(game_event, category)
    game_event.game_type == GameEvent::GAME_TYPE_COMPLETED && game_event.game.category == category
  end

  def user_params
    params.permit(:email, :username, :fullname, :password)
  end

  def game_event_params
    params.require(:game_event).permit(:type, :occured_at, :game_id)
  end
end

class GamesController < ApplicationController
  def index
    games_json = Game.all.each.map do |game|
      { id: game.id, name: game.name, url: game.url, category: game.category }
    end

    render json: { games: games_json}
  end
end

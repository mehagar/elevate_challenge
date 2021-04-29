require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /index" do
    it "returns list of games" do
      game1 = Game.create(name: 'game1', url: 'http://game1', category: 'math')
      game2 = Game.create(name: 'game2', url: 'http://game2', category: 'math')
      game3 = Game.create(name: 'game3', url: 'http://game3', category: 'math')

      get "/games/index"

      expect(json[:games].length).to eq(3)
      expect(json[:games][0][:id]).to eq(game1.id)
      expect(json[:games][1][:id]).to eq(game2.id)
      expect(json[:games][2][:id]).to eq(game3.id)
    end
  end
end

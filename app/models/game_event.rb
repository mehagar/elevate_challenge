class GameEvent < ApplicationRecord
  belongs_to :game
  belongs_to :user

  GAME_TYPE_COMPLETED = 'COMPLETED'.freeze

  validates_inclusion_of :game_type, in: [GAME_TYPE_COMPLETED]
end

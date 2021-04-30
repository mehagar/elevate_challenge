class Game < ApplicationRecord
  has_many :game_events

  GAME_CATEGORIES = %w[math reading speaking writing].freeze

  validates_inclusion_of :category, in: GAME_CATEGORIES
end

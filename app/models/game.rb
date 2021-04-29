class Game < ApplicationRecord
  validates_inclusion_of :category, in: %w( math reading speaking writing )
end

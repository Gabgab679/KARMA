class Game < ApplicationRecord
  has_many :favorites
  has_many :events
end

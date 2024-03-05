class Game < ApplicationRecord
  has_many :users, through: :favorites
  has_many :events
end

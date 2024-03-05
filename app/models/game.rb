class Game < ApplicationRecord
  has_many :users, trough: :favorite
  has_many :events
end

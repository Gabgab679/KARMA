class Game < ApplicationRecord
  has_many :users, trough: :favorite
  # Jsuis pas censé touché a ce fichier dans ma branche mais jcrois qu'il y a un has_many :events ici
end

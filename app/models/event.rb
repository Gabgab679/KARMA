class Event < ApplicationRecord
  belongs_to :user #belongs to and has many users ou les deux séparés ?
  belongs_to :game
end

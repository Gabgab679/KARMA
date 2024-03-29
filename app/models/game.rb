class Game < ApplicationRecord
  has_many :users, through: :favorites
  has_many :events
  has_many :favorites

  include PgSearch::Model
  pg_search_scope :global_search, against: [:name], associated_against: {
    event: [:name]
  },
  using: {
    tsearch: { prefix: true }
  }
end

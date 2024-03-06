class Event < ApplicationRecord
  STATUS = ['Open', 'Cancelled', 'Fully booked']
  EVENT_TYPE = ['Casual', 'Tournament']

  belongs_to :user
  belongs_to :game
  has_many :participations

  validates :name, presence: true
  validates :event_type, presence: true, inclusion: { in: EVENT_TYPE }
  validates :description, presence: true
  validates :date, presence: true
  validates :address, presence: true
  validates :status, presence: true, inclusion: { in: STATUS }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :global_search, against: [:name], associated_against: {
    game: [:name]
  },
  using: {
    tsearch: { prefix: true }
  }
end

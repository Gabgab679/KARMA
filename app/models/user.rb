class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :favorites
  has_many :events_participations, through: :participations, source: :event
  has_many :request_participations, through: :events, source: :participations
  has_many :games, through: :favorites
  has_one_attached :photo
  has_many :messages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :events_participations, through: :participations, source: :events, dependent: :destroy
  has_many :games, through: :favorites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

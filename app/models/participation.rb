class Participation < ApplicationRecord
  STATUS = ['Pending', 'Accepted']
  belongs_to :user
  belongs_to :event
end

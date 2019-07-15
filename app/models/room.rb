class Room < ApplicationRecord
  belongs_to :flat
  has_many :users, through: :bookings
end

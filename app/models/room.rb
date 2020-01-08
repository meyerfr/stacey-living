class Room < ApplicationRecord
  belongs_to :project
  has_many :users, through: :bookings
  has_many :room_amenities
  has_many :amenities, through: :room_amenities
end

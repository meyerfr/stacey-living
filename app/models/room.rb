class Room < ApplicationRecord
  belongs_to :roomtype
  has_many :bookings
  has_one :project, through: :roomtype
  # has_one :booking, required: false
end

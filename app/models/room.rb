class Room < ApplicationRecord
  validates :intern_number, :house_number, :state, presence: true
  belongs_to :roomtype
  has_many :bookings
  has_one :project, through: :roomtype
  # has_one :booking, required: false
end

class Flat < ApplicationRecord
  validates :street, :zipcode, :city, presence: true
  has_many :bookings
end

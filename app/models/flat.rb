class Flat < ApplicationRecord
  validates :project_name, :street, :zipcode, :city, presence: true
  has_many :bookings
end

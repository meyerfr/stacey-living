class Price < ApplicationRecord
  belongs_to :roomtype
  has_many :bookings, dependent: :nullify
end

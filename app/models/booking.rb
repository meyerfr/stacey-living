class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room_attribute
  has_many :contracts, dependent: :destroy
  has_many :welcome_calls, dependent: :destroy
end

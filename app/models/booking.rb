class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room, optional: true
  has_many :contracts
  has_many :welcome_calls
end

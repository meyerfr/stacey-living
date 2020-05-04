class RoomAttribute < ApplicationRecord
  belongs_to :roomtype
  belongs_to :booking, optional: true
  # has_one :booking, required: false
end

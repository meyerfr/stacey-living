class RoomAttribute < ApplicationRecord
  belongs_to :room
  belongs_to :booking, optional: true
end

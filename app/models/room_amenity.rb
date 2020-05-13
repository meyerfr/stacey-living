class RoomAmenity < ApplicationRecord
  belongs_to :amenity, :roomtype
end

class Amenity < ApplicationRecord
  has_many :room_amenities
  has_many :project_amenities
end

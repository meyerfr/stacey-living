class Amenity < ApplicationRecord
  with_options dependent: :destroy do |assoc|
    assoc.has_many :room_amenities
    assoc.has_many :project_amenities
  end
end

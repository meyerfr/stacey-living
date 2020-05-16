class Amenity < ApplicationRecord
  with_options dependent: :destroy do |assoc|
    assoc.has_many :join_amenities, as: :amenitiable
  end
  has_many :projects, through: :join_amenities
  has_many :roomtypes, through: :join_amenities
end

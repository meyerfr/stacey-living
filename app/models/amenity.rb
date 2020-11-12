class Amenity < ApplicationRecord
  has_one_attached :photo

  has_many :join_amenities, dependent: :destroy

  has_many :projects, through: :join_amenities
  has_many :roomtypes, through: :join_amenities
end

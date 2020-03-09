class Room < ApplicationRecord
  mount_uploaders :pictures, PictureUploader
  belongs_to :project
  has_many :users, through: :bookings
  has_many :room_amenities, dependent: :destroy
  has_many :amenities, through: :room_amenities
  accepts_nested_attributes_for :room_amenities, allow_destroy: true, reject_if: proc{ |att| att['amenity_id'].nil? }
end

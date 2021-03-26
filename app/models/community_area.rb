class CommunityArea < ApplicationRecord
  belongs_to :project
  has_many_attached :photos
  has_many :descriptions, as: :descriptionable, dependent: :destroy
  has_many :join_amenities, as: :amenitiable, dependent: :destroy
  has_many :amenities, through: :join_amenities

  accepts_nested_attributes_for :join_amenities, :descriptions, allow_destroy: true
  validates_associated :descriptions, :join_amenities

  def all_amenities
    amenities = self.amenities
    amenities = amenities.map {|amenity|
      amenity.as_json.merge({ photo: rails_blob_path(amenity.photo, disposition: "attachment", only_path: true) }) if amenity.photo.attached?
    }
    return amenities
  end
end

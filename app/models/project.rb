class Project < ApplicationRecord
  mount_uploaders :pictures, PictureUploader
  has_many :rooms, dependent: :destroy
  has_many :project_amenities, dependent: :destroy
  has_many :amenities, through: :project_amenities
  accepts_nested_attributes_for :project_amenities, allow_destroy: true, reject_if: proc{ |att| att['amenity_id'].nil? }
  accepts_nested_attributes_for :rooms, allow_destroy: true, reject_if: proc{ |att| att['size'].blank? }
end

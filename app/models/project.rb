class Project < ApplicationRecord
  mount_uploaders :pictures, PictureUploader
  has_many :rooms, dependent: :destroy
  has_many :project_amenities
  has_many :amenities, through: :project_amenities
  accepts_nested_attributes_for :amenities
  accepts_nested_attributes_for :rooms, allow_destroy: true, reject_if: proc{ |att| att['size'].blank? }
end

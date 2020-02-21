class Project < ApplicationRecord
  mount_uploaders :pictures, PictureUploader
  has_many :rooms
  has_many :project_amenities
  has_many :amenities, through: :project_amenities
end

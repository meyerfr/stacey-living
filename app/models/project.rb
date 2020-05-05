class Project < ApplicationRecord
  # mount_uploaders :pictures, PictureUploader
  before_save :clean_up_data
  has_many_attached :photos

  has_one :address, as: :addressable, required: true
  has_many :descriptions, as: :descriptionable, dependent: :destroy
  has_many :roomtypes, dependent: :destroy
  has_many :project_amenities, dependent: :destroy
  has_many :amenities, through: :project_amenities
  accepts_nested_attributes_for :project_amenities, allow_destroy: true, reject_if: proc{ |att| att['amenity_id'].nil? }
  accepts_nested_attributes_for :roomtypes, allow_destroy: true
  validates_associated :roomtypes


  def clean_up_data
    self.name = self.name.downcase.titleize
    self.street = self.street.downcase.titleize
    self.city = self.city.downcase.titleize
  end
end

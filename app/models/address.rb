class Address < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  belongs_to :addressable, polymorphic: true
  has_one :description, as: :descriptionable, dependent: :destroy
  accepts_nested_attributes_for :description
  validates_associated :description

  validate :description_requirement

  def address
    [street, number, city, zip, country].compact.join(', ')
  end

  def description_requirement
    if !self.description.present? && self.parent.class == Project
      errors.add(:description, 'must be present')
    end
  end
end

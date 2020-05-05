class Address < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  belongs_to :addressable, polymorphic: true
  has_many :descriptions, as: :descriptionable, dependent: :destroy

  def address
    [street, city, zip, country].compact.join(', ')
  end
end

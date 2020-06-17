class CommunityArea < ApplicationRecord
  belongs_to :project
  has_many_attached :photos
  has_many :descriptions, as: :descriptionable, dependent: :destroy
  has_many :join_amenities, as: :amenitiable, dependent: :destroy

  accepts_nested_attributes_for :join_amenities, :descriptions
  validates_associated :descriptions, :join_amenities
end

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  has_many :descriptions, as: :descriptionable, dependent: :destroy
end

class Contract < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking
  accepts_nested_attributes_for :user
end

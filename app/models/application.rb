class Application < ApplicationRecord
  belongs_to :user

  validates :move_in, :move_out, :prefered_location, presence: true

  accepts_nested_attributes_for :user, allow_destroy: true
end

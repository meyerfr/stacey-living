class Application < ApplicationRecord
  belongs_to :user

  # validates :move_in, :move_out, presence: true

  accepts_nested_attributes_for :user, allow_destroy: true
end

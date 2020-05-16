class JoinAmenity < ApplicationRecord
  belongs_to :amenitiable, polymorphic: true
  belongs_to :amenity

  def name_input
    name_options = [
      'project index',
      'project show',
      'roomtype index',
      'roomtype show',
    ]
    if self.name.present? && name_options.exclude?(self.name)
      errors.add(:name, "is not part of name options")
    end
  end
end

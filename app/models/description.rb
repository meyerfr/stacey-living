class Description < ApplicationRecord
  belongs_to :descriptionable, polymorphic: true
  validates :field, :content, presence: true
  # validate :field_input

  def field_input
    field_options = [
      'project info index',
      'project info show',
      'address info',
      'community space info',
      'roomtype info'
    ]
    if self.field.present? && field_options.exclude?(self.field)
      errors.add(:field, "is not part of field options")
    end
  end
end

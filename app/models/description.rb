class Description < ApplicationRecord
  belongs_to :descriptionable, polymorphic: true
  validates :field, :content, presence: true
  validate :field_input

  def field_input
    field_options = [
      'project_info_index',
      'project_info_show',
      'address_info',
      'community_space_info',
      'roomtype_info'
    ]
    if self.field.present? && field_options.exclude?(self.field)
      errors.add(:field, "is not part of field options")
    end
  end
end

class Project < ApplicationRecord
  # mount_uploaders :pictures, PictureUploader
  cattr_accessor :form_steps do
    %w(project_info address rooms)
  end

  attr_accessor :form_step

  with_options dependent: :destroy do |assoc|
    assoc.has_one :address, as: :addressable, required: false
    assoc.has_many :descriptions, as: :descriptionable
    assoc.has_many :join_amenities, as: :amenitiable
    assoc.has_many :roomtypes
  end

  has_many :rooms, through: :roomtypes
  has_many :amenities, through: :join_amenities
  has_many_attached :photos

  accepts_nested_attributes_for :address, :descriptions, :join_amenities, :roomtypes, allow_destroy: true

  # before_save :clean_up_data

  with_options if: -> { required_for_step?(:project_info) } do |step|
    step.validates :name, presence: true
    step.validates_associated :descriptions
    step.validate :minimum_descriptions
    # step.validates_associated :project_amenities
  end

  with_options if: -> { required_for_step?(:address) } do |step|
    step.validates_associated :address
  end

  # with_options if: -> { required_for_step?(:project_amenities) } do |step|
  #   step.validates_associated :project_amenities
  # end

  with_options if: -> { required_for_step?(:rooms) } do |step|
    step.validates_associated :roomtypes
  end

  def active?
    status == 'active'
  end

  def minimum_descriptions
    unless self.descriptions.collect(&:field).any? { |i| ['project info index', 'project info show'].include? i }
      errors.add(:project, 'needs more descriptions')
    end
  end

  # def clean_up_data
  #   self.name = self.name.downcase.titleize
  #   self.street = self.street.downcase.titleize
  #   self.city = self.city.downcase.titleize
  # end

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
end

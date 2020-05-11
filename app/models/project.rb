class Project < ApplicationRecord
  # mount_uploaders :pictures, PictureUploader
  cattr_accessor :form_steps do
    %w(project_info address project_amenities rooms)
  end

  attr_accessor :form_step

  # before_save :clean_up_data
  has_one :address, as: :addressable, required: false
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many_attached :photos
  has_many :descriptions, as: :descriptionable, dependent: :destroy
  accepts_nested_attributes_for :descriptions, allow_destroy: true
  has_many :roomtypes, dependent: :destroy
  has_many :project_amenities, dependent: :destroy
  has_many :amenities, through: :project_amenities
  accepts_nested_attributes_for :project_amenities, allow_destroy: true
  accepts_nested_attributes_for :roomtypes, allow_destroy: true
  validates_associated :roomtypes

  with_options if: -> { required_for_step?(:project_info) } do |step|
    step.validates :name, presence: true
    step.validates_associated :descriptions
    step.validate :minimum_descriptions
  end

  with_options if: -> { required_for_step?(:address) } do |step|
    step.validates_associated :address
  end

  with_options if: -> { required_for_step?(:project_amenities) } do |step|
    step.validates_associated :project_amenities
  end

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

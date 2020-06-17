class Booking < ApplicationRecord
  cattr_accessor :form_steps do
    %w(apply projects rooms room contract_new contract payment success)
  end

  attr_accessor :form_step

  # validate :move_in_future, :minimum_duration
  belongs_to :user
  belongs_to :room, optional: true
  has_one :contract

  accepts_nested_attributes_for :user, :contract
  validates_associated :contract


  with_options if: -> { required_for_step?(:apply) } do |step|
    step.validates_associated :user
    # step.validates_associated :project_amenities
  end
  # accepts_nested_attributes_for :user
  # validates_associated :user

  with_options dependent: :destroy do |assoc|
    assoc.has_many :welcome_calls
  end

  # Validate whether the start time is in the future
  def move_in_future
    if move_in.present? && move_in < Date.today
      errors.add(:move_in, "can´t be in the past.")
    end
  end

  # Validate whether the end_time is at least 3 hrs after the start_time
  def minimum_duration
    if move_in.present? && move_out.present? && move_out < (move_in.advance(:months => 3))
      errors.add(:move_out, "3 Months minimum")
    end
  end

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

  # Validate whether the availability is not overlapping any already existing availabilities
  # def booking_overlap
  #   if start_time.present? && end_time.present?
  #     Availability.where(sitter: sitter).each do |availability|
  #       if start_time > availability.start_time.advance(:hours => -0.5) && start_time < availability.end_time.advance(:hours => +0.5)
  #         errors.add(:start_time, "is within 30 minutes of or during another one of your availabilities.")
  #         break
  #       elsif end_time > availability.start_time.advance(:hours => -0.5) && end_time < availability.end_time.advance(:hours => +0.5)
  #         errors.add(:end_time, "is within 30 minutes of or during another one of your availabilities.")
  #         break
  #       end
  #     end
  #   end
  # end
end

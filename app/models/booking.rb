class Booking < ApplicationRecord
  cattr_accessor :form_steps do
    %w(apply projects rooms room contract_new contract payment success)
  end

  attr_accessor :form_step

  # validate :move_in_future, :minimum_duration
  belongs_to :user
  belongs_to :room, optional: true
  belongs_to :price, optional: true
  has_one :roomtype, through: :room, required: false
  has_one :project, through: :room, required: false
  has_one :contract, required: false

  validates :move_in, :move_out, presence: true

  accepts_nested_attributes_for :user, :contract, :price, allow_destroy: true


  with_options if: -> { required_for_step?(:apply) } do |step|
    step.validates_associated :user
  end

  with_options if: -> { required_for_step?(:contract_new) } do |step|
    step.validates_associated :contract
  end


  with_options dependent: :destroy do |assoc|
    assoc.has_many :welcome_calls
  end

  # def move_in_dates
  #   errors.add(:move_in, 'Must be in the future') unless self.move_in >= Date.today
  # end

  # Validate whether the start time is in the future
  def move_in_future
    if move_in.present? && move_in < Date.today
      errors.add(:move_in, "can´t be in the past.")
    end
  end

  # Validate whether the end_time is at least 3 hrs after the start_time
  def minimum_duration
    # if move_in.present? && move_out.present? && move_out < (move_in.advance(:months => 3) - 1.day)
    unless duration >= 3
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

  def duration
    if move_in.present? && move_out.present?
      ((move_out.year - move_in.year) * 12) + (move_out.month - move_in.month) - ((move_out.day >= move_in.day ? 0 : 1))
    end
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

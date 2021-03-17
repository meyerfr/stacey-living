class Booking < ApplicationRecord
  after_save :send_mail_on_state_change

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
  has_one :contract, required: false, dependent: :destroy

  accepts_nested_attributes_for :contract, allow_destroy: true

  def send_mail_on_state_change
    return unless self.state_changed?
    case(self.state)
    when 'deposit outstanding'
      BookingMailer.booking_process_completed(booking)
      stage_id = 14
    when 'booked'
      BookingMailer.deposit_received(booking)
      booking.user.update(role: 'tenant')
      stage_id = 15
    when 'cancel'
      BookingMailer.deposit_not_received(booking)
      # stage_id =
    end
    self.change_pipedrive_stage(stage_id) if stage_id
  end

  def change_pipedrive_stage(stage_id)
    RestClient.put(
      self.pipedrive_api_url("deals/#{booking.pipedrive_deal_id}"),
      {
        "stage_id": stage_id,
      }.to_json,
      {content_type: :json, accept: :json}
    )
  end

  def pipedrive_api_url(action)
    "https://api.pipedrive.com/v1/#{action}?api_token=#{ENV['PIPEDRIVE_API_TOKEN']}"
  end

  # validates :move_in, :move_out, presence: true

  # accepts_nested_attributes_for :user, :contract, :price, allow_destroy: true


  # with_options if: -> { required_for_step?(:apply) } do |step|
  #   step.validates_associated :user
  # end

  # with_options if: -> { required_for_step?(:contract_new) } do |step|
  #   step.validates_associated :contract
  # end


  # with_options dependent: :destroy do |assoc|
  #   assoc.has_many :welcome_calls
  # end

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

  def find_price
    unless self.roomtype && self.roomtype.prices.length > 0
      return
    end

    prices = self.roomtype.prices.order(amount: :desc)
    duration = self.duration
    case(true)
    when (duration < 5)
      return prices.first
    when (duration < 8)
      return price = prices.second
    else
      return price = prices.last
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

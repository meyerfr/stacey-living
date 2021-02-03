class Room < ApplicationRecord
  validates :intern_number, :house_number, :state, presence: true
  belongs_to :roomtype
  has_many :bookings
  has_one :project, through: :roomtype
  # has_one :booking, required: false

  def next_available_move_in_date
  	bookings = self.bookings.where(state: ['booked', 'deposit outstanding']).order(:move_out)
  	# if self.bookable_date && self.bookable_date <= Date.today
    if bookings.empty? || bookings.last.move_out&.past?
      Date.tomorrow
    elsif !bookings.last.move_out.nil?
      bookings.last.move_out + 1.day
    end
  end
end

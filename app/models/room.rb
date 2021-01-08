class Room < ApplicationRecord
  validates :intern_number, :house_number, :state, presence: true
  belongs_to :roomtype
  has_many :bookings
  has_one :project, through: :roomtype
  # has_one :booking, required: false

  def next_available_move_in_date
  	bookings = self.bookings.where(state: ['booked', 'booking outstanding']).order(:move_out)
  	if self.bookable_date <= Date.today
  		if bookings.count > 0 && bookings.last.move_out >= Date.today
  			bookings.last.move_out + 1.day
  		else
  			Date.tomorrow
  		end
  	else
  		false
  	end
  end
end

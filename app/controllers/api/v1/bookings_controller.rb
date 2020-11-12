class Api::V1::BookingsController < ActionController::Base
	def update
		booking = Booking.find(params[:id])
		booking.assign_attributes(bookings_params)
		booking.save(validate: false)

		render json: booking
	end

	private

	def bookings_params
	  params.require(:booking).permit(:move_in, :move_out, :room_id)
	end

end

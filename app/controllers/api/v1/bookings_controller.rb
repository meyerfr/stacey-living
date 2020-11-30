class Api::V1::BookingsController < ActionController::Base
	def update
		booking = Booking.find(params[:id])
		booking.assign_attributes(bookings_params)
		booking.save(validate: false)

		render json: booking
	end

	def show
		booking = Booking.find(params[:id])
		user = booking.user
		booking = booking.as_json.merge(
			{
				user: user,
				roomtype: booking.roomtype.name,
				duration: (booking.move_out - booking.move_in).to_i,
				price: booking.price.amount
			}
		)

		render json: booking
	end

	private

	def bookings_params
	  params.require(:booking).permit(:move_in, :move_out, :room_id)
	end

end

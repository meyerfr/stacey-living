class Api::V1::RoomtypesController < ActionController::Base
	def index
		roomtypes = Roomtype.where(project_id: params[:project_id])

		roomtypes = roomtypes.map { |roomtype|
			cheapest_price = roomtype.cheapest_price
			photos = roomtype.photos.map { |photo|
								 url_for(photo)	
							 }
			next_available_move_in = roomtype.next_available_move_in_date
			roomtype.as_json.merge({ cheapest_price: cheapest_price, photos: photos, next_available_move_in: next_available_move_in })
		}

		render json: roomtypes
		# bookings = @bookings.map { |booking|
	 #      room = booking.room
	 #      roomtype = room.roomtype
	 #      user = booking.user
	 #      booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
	 #    }
	end

	def show
		roomtype = Roomtype.find(params[:id])
		availabilities = roomtype.availabilities
		photos = roomtype.photos.map { |photo|
			url_for(photo)
		}
		prices = roomtype.prices.order(amount: :desc).collect(&:amount)
		roomtype = roomtype.as_json.merge({photos: photos, availabilities: availabilities, prices: prices})
		render json: roomtype
	end
end

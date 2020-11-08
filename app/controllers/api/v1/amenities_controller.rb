class Api::V1::AmenitiesController < ActionController::Base
	def index
		amenities = Project.find(params[:project_id]).amenities
		amenities = amenities.map { |amenity|
	      amenity.as_json.merge({ photo: url_for(amenity.photo) })
	    }
		render json: amenities
		# bookings = @bookings.map { |booking|
	 #      room = booking.room
	 #      roomtype = room.roomtype
	 #      user = booking.user
	 #      booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
	 #    }
	end
end

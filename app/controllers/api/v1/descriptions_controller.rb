class Api::V1::DescriptionsController < ActionController::Base
	def index
		type = params[:type]
		id = params[:type_id]
		if type === 'project'
			descriptions = Project.find(id).all_descriptions
		elsif type === 'roomtype'
			descriptions = Roomtype.find(id).all_descriptions
		end
		# descriptions = Project.find(params[:project_id]).all_descriptions
		render json: descriptions
		# bookings = @bookings.map { |booking|
	 #      room = booking.room
	 #      roomtype = room.roomtype
	 #      user = booking.user
	 #      booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
	 #    }
	end
end

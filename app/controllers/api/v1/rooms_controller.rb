class Api::V1::RoomsController < ActionController::Base
	before_action :set_filter

	def index
		bookings = @bookings.map { |booking|
	      room = booking.room
	      roomtype = room.roomtype
	      booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number })
	    }

	    render json: bookings
	end

	# private

	def set_filter
		filter = params[:filter]
		case filter
		when 'project_name'
			sql_query = "name ILIKE :query"
			projects = Project.where(sql_query, query: "%#{params[:project_name]}%")
			@bookings = Booking.select{|b| b.state == 'booked' && projects.include?(b.project)}
			# projects.each{|p| bookings << p.bookings.where(state: 'booked')}
		when 'roomtype_name'
			sql_query = "name ILIKE :query"
			roomtypes = Roomtype.where(sql_query, query: "%#{params[:roomtype_name]}%")
			@bookings = Booking.select{|b| b.state == 'booked' && roomtypes.include?(b.roomtype)}
			# roomtypes.each{|roomtype| bookings << roomtype.bookings.where(state: 'booked')}
		when 'apartment_number'
			sql_query = "apartment_number ILIKE :query"
			rooms = Room.where(sql_query, query: "%#{params[:apartment_number]}%")
			@bookings = Booking.select{|b| b.state == 'booked' && rooms.include?(b.room)}
			# rooms.each{|room| bookings << room.bookings.where(state: 'booked')}
		when 'room_number'
			sql_query = "intern_number ILIKE :query"
			rooms = Room.where(sql_query, query: "%#{params[:room_number]}%")
			@bookings = Booking.select{|b| b.state == 'booked' && rooms.include?(b.room)}
		when 'user_name'
			sql_query = " \
		        users.first_name ILIKE :query \
		        OR users.last_name ILIKE :query \
		        OR users.email ILIKE :query \
		    "
	      	users = User.where(sql_query, query: "%#{params[:user_name]}%")
	      	@bookings = Booking.select{|b| b.state == 'booked' && users.include?(b.user)}
	      	# users.each{|user| bookings << user.bookings.where(state: 'booked')}
		when 'move_in'
			case params[:move_in]
			when 'past'
				@bookings = Booking.where(
					'move_out <= :todays_date AND state = :booked_state',
					todays_date: Date.today,
					booked_state: 'booked'
				)
			when 'current'
				@bookings = Booking.where(
			        "bookings.move_in <= :todays_date AND move_out >= :todays_date AND state = :booked_state",
			        todays_date: Date.today,
			        booked_state: 'booked'
			      ).order(created_at: :desc)
			when 'upcoming'
				@bookings = Booking.where(
					'move_in >= :todays_date AND state = :booked_state',
				 	todays_date: Date.today,
				 	booked_state: 'booked'
				 )
			else
				@bookings = Booking.all.where(state: 'booked')
			end
		else
			@bookings = Booking.all.where(state: 'booked')
		end

		# roomtype_name = params[:roomtype_name]
		# project_id = params[:project_id]
		# room_id = params[:room_id]
		# apartment_id = params[:apartment_id]
		# start_date = params[:start_date]
		# end_date = params[:end_date]
	end
end

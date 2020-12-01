class Api::V1::BookingsController < ActionController::Base
	before_action :set_filter, only: [ :index ]

	def index
		bookings = @bookings.map { |booking|
      room = booking.room
      roomtype = room.roomtype
      user = booking.user
      booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone: "#{user.phone_code} #{user.phone_number}" })
    }

    render json: bookings
	end

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

	def set_filter
		filter = params[:filter]
		case filter
		when 'project_name'
			if params[:project_name] == 'all'
				@bookings = Booking.all.where(state: 'booked')
			else
				sql_query = "name ILIKE :query"
				projects = Project.where(sql_query, query: "%#{params[:project_name]}%")
				@bookings = Booking.select{|b| b.state == 'booked' && projects.include?(b.project)}
			end
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
	end

end

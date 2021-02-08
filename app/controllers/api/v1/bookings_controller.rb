class Api::V1::BookingsController < ActionController::Base
  # before_action :check_booking_auth_token!, only: [:create, :update]

	before_action :set_filter, only: [ :index ]

  def create
    user = User.find(params[:user_id])
    application = user.application
    booking = user.bookings.new(
      state: 'invite send',
      booking_auth_token: Devise.friendly_token,
      booking_auth_token_exp: Date.today+2.weeks,
      pipedrive_deal_id: application.pipedrive_deal_id
    )
    # booking.user.skip_password_validation = true
    if booking.save!
      # send invite to Booking Process
      BookingMailer.invite_for_booking_process(booking).deliver_now
      render json: booking
      # redirect_to new_booking_welcome_call_path(booking.booking_auth_token, booking)
    else
      render json: booking.errors
    end
  end

	def index
    if @bookings.present?
  		bookings = @bookings.map { |booking|
        room = booking.room
        roomtype = room.roomtype
        user = booking.user
        booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone_code: user.phone_code, phone_number: user.phone_number })
      }

      bookings = bookings.sort_by { |hash| hash['move_in'] }
    end

    render json: bookings
	end

	def update
		booking = Booking.find(params[:id])

    if params[:state] != booking.state
      case params[:state]
      when 'booked'
        BookingMailer.deposit_received(booking)
      when 'deposit outstanding'
        BookingMailer.booking_process_completed(booking)
        booking.booking_process_completed_date = Date.today
      when 'deposit received'
        BookingMailer.booking_process_completed(booking)
        booking.user.update(role: 'tenant')
      when 'cancel'
        BookingMailer.deposit_not_received(booking)
      end
    end

		booking.assign_attributes(bookings_params)
		booking.save!(validate: false)


    room = booking.room
    roomtype = room.roomtype
    user = booking.user
    booking = booking.as_json.merge({ project_name: booking.project.name, user_name: booking.user.full_name, roomtype_name: roomtype.name, room_number: room.intern_number, apartment_number: room.apartment_number, phone_code: user.phone_code, phone_number: user.phone_number })

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
	  params.require(:booking).permit(
      :move_in,
      :move_out,
      :room_id,
      :state,
      user_attributes: [
        :first_name,
        :last_name,
        :email,
        :phone_number,
        :dob
      ]
    )
	end

	def set_filter
		filter = params[:filter]
		case filter
    when 'booking_state'
      if params[:booking_state] == 'all'
        @bookings = Booking.where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'])
      else
        @bookings = Booking.where(state: params[:booking_state])
      end
		when 'project_name'
			if params[:project_name] == 'all'
				@bookings = Booking.where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'])
			else
				sql_query = "name ILIKE :query"
				projects = Project.where(sql_query, query: "%#{params[:project_name]}%")
				@bookings = Booking.select{|b| ['booked', 'deposit outstanding', 'bookingFee payment failed'].include?(b.state) && projects.include?(b.project)}
			end
			# projects.each{|p| bookings << p.bookings.where(state: 'booked')}
		when 'roomtype_name'
			sql_query = "name ILIKE :query"
			roomtypes = Roomtype.where(sql_query, query: "%#{params[:roomtype_name]}%")
      @bookings = Booking.joins(:room).where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'], rooms: {roomtype_id: roomtypes.collect(&:id)})
			# roomtypes.each{|roomtype| bookings << roomtype.bookings.where(state: 'booked')}
		when 'apartment_number'
			sql_query = "apartment_number ILIKE :query"
			rooms = Room.where(sql_query, query: "%#{params[:apartment_number]}%")
      @bookings = Booking.where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'], room_id: rooms.collect(&:id))
			# rooms.each{|room| bookings << room.bookings.where(state: 'booked')}
		when 'room_number'
			sql_query = "intern_number ILIKE :query"
			rooms = Room.where(sql_query, query: "%#{params[:room_number]}%")
      @bookings = Booking.where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'], room_id: rooms.collect(&:id))
		when 'user_name'
			sql_query = " \
		        users.first_name ILIKE :query \
		        OR users.last_name ILIKE :query \
		        OR users.email ILIKE :query \
		    "
    	users = User.where(sql_query, query: "%#{params[:user_name]}%")
      @bookings = Booking.where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'], user_id: users.collect(&:id))
		when 'move_in'
			case params[:move_in]
			when 'past'
        @bookings = Booking.where(
                      "move_out <= ?",
                      Date.today
                    ).where({
                      state: ['booked', 'deposit outstanding', 'bookingFee payment failed']
                    })
			when 'current'
        @bookings = Booking.where(
                      "move_in <= :todays_date AND move_out >= :todays_date",
                      todays_date: Date.today
                    ).where({
                      state: ['booked', 'deposit outstanding', 'bookingFee payment failed']
                    }).order(created_at: :desc)
			when 'upcoming'
        @bookings = Booking.where(
                      "move_in >= ?",
                      Date.today
                    ).where({
                      state: ['booked', 'deposit outstanding', 'bookingFee payment failed']
                    })
			else
				@bookings = Booking.where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'])
			end
		else
			@bookings = Booking.where(state: ['booked', 'deposit outstanding', 'bookingFee payment failed'])
		end
	end

end

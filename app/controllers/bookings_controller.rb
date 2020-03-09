class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_param_options = ['current', 'upcoming', 'past', 'all']

    @room_name_param = params[:room_name].present? ? params[:room_name] : 'all'
    @time_param = params[:time].present? ? params[:time] : 'all'
    search_param = params[:search] if params[:search].present?
    @bookings = Booking.order(created_at: :desc).select{ |b| b.move_in <= Date.today && b.move_out >= Date.today && b.state == 'booked' }
    if @room_name_param == 'all'
      @room_name = @room_name_param
      @bookings = Booking.order(created_at: :desc).where(state: 'booked')
      # @bookings = Booking.select{ |booking| booking.move_in >= Date.today && state == nil }
    else
      @room_name = Room.select{ |room| room.name.delete(' ').downcase == @room_name_param.delete(' ').downcase }.first.name
      if @room_name && @bookings.length.positive?
        @bookings = @bookings.select{ |booking| booking.room.name.delete(' ').downcase == @room_name.downcase }
      end
    end

    if @time_param == 'upcoming'
      @bookings = @bookings.select{ |booking| booking.move_in >= Date.today}
    elsif @time_param == 'past'
      @bookings = @bookings.select{ |booking| booking.move_out <= Date.today}
    elsif @time_param == 'current'
      @bookings = @bookings.select{ |booking| booking.move_in <= Date.today && booking.move_out >= Date.today}
    end

    if search_param
      sql_query = " \
        users.first_name @@ :search \
        OR users.last_name @@ :search \
        OR users.email @@ :search \
        OR CONCAT(users.first_name, ' ', users.last_name) @@ :search
      "
      users = User.where(sql_query, search: "%#{params[:search]}%")

      @bookings = Booking.order(created_at: :desc).select{|b| users.include?(b.user) }
    end

    @all_room_names = find_all_room_names
    @available_booking_times = find_available_booking_dates(@bookings)
    respond_to do |format|
      format.html { render 'bookings/index' }
      format.js  # <-- will render `app/views/bookings/index.js.erb`
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.room_id = params[:room]
    # move_in = Booking.select{ |b| b.room.name == @booking.room.name && b.state == nil && b.move_out >= Date.today }.last.move_out + 1.day
    if @booking.update(bookings_params)
      flash[:alert] = "Booking successfully updated."
      redirect_to new_booking_contract_path(@booking.booking_auth_token, @booking)
    else
      flash[:alert] = "Oops something went wrong. Please try again."
      redirect_to booking_project_room_path(@booking.booking_auth_token, @booking, @booking.project, @booking.room)
    end
  end

  def payment
    @booking = Booking.find(params[:id])
  end

  private

  def bookings_params
    params.require(:booking).permit(:move_in, :move_out)
  end

  def check_duration_between_bookings(first_booking, second_booking)
    # if booking is less than three return false, else return true
    return false unless second_booking.present?
    move_out = first_booking.move_out
    next_move_in = second_booking.move_in
    duration = (next_move_in.year - move_out.year) * 12 + next_move_in.month - move_out.month - (next_move_in.day >= move_out.day ? 0 : 1)
    duration >= 3 ? true : false
  end

  def find_available_booking_dates(bookings)
    available_booking_times = []
    bookings.each_with_index do |booking, index|
      next unless check_duration_between_bookings(booking, bookings[index + 1])
      available_booking_times << "#{(booking.move_out + 1.day).strftime('%d.%B %Y')} - #{(bookings[index + 1].move_in - 1.day).strftime('%d.%B %Y')}"
    end
    if bookings.length.positive?
      available_booking_times << "#{(bookings.last.move_out + 1.day).strftime('%d.%B %Y')} - open"
    else
      available_booking_times << "today - open"
    end
    available_booking_times
  end

  def find_all_room_names
    room_names = []
    Room.all.each{ |room| room_names << room.name unless room_names.include?(room.name)}
    room_names.unshift('all')
  end
end

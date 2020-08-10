class BookingsController < ApplicationController
  before_action :authenticate_user!

  BOOKINGS_PER_PAGE = 25

  def index
    @time_param_options = ['all', 'current', 'upcoming', 'past']

    @project_param = params[:project_name].present? ? params[:project_name] : 'all'
    if @project_param != 'all'
      @project = Project.find_by(name: @project_param)
    end

    @room_name_param = params[:room_name].present? ? params[:room_name] : 'all'

    @time_param = params[:time].present? ? params[:time] : 'all'

    search_param = params[:search] if params[:search].present?

    @project_names = Project.all.collect(&:name).unshift('all')

    @bookings = Booking.where(state: 'booked').order(created_at: :desc)

    if @project_param == 'all'
      @total_room_number = Room.count
    else
      @bookings = @project.bookings.where(state: 'booked').order(:move_in)
      # @bookings = @bookings.includes(:project).where('projects.name = :project_name', project_name: @project_param)
      @total_room_number = @project.rooms.count
    end

    if @room_name_param == 'all'
      @total_room_number = @project_param == 'all' ? Room.count : @project.rooms.count

      @room_name = @room_name_param
    else
      @room_name = Roomtype.find_by(name: @room_name_param).name
      @bookings = @bookings.joins(room: :roomtype).where('roomtypes.name = :room_name', room_name: @room_name)
      @total_room_number = if @project.present?
                             @project.rooms.joins(:roomtype).where('roomtypes.name = :room_name', room_name: @room_name).count
                           else
                             Room.joins(:roomtype).where('roomtypes.name = :room_name', room_name: @room_name).count
                           end
    end

    @total_current_room_bookings = @bookings.count

    if @time_param == 'upcoming'
      # @bookings = @bookings.select{ |booking| booking.move_in >= Date.today}
      @bookings = @bookings.where('move_in >= ?', Date.today)
    elsif @time_param == 'past'
      # @bookings = @bookings.select{ |booking| booking.move_out <= Date.today}
      @bookings = @bookings.where('move_out <= ?', Date.today)
    elsif @time_param == 'current'
      # @bookings = @bookings.select{ |booking| booking.move_in <= Date.today && booking.move_out >= Date.today}
      @bookings = @bookings.where(
        "move_in <= :todays_date AND move_out >= :todays_date AND state = :booked_state",
        todays_date: Date.today,
        booked_state: 'booked'
      ).order(created_at: :desc)
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
    else
      @page = params.fetch(:page, 0).to_i
      @page_count = @bookings.count / BOOKINGS_PER_PAGE
      @bookings = @bookings.offset(@page * BOOKINGS_PER_PAGE).limit(BOOKINGS_PER_PAGE)
    end

    @all_room_names = Roomtype.order(:size).collect(&:name).uniq.unshift('all')
    # @available_booking_times = find_available_booking_dates(@bookings)
    respond_to do |format|
      format.html { render 'bookings/index' }
      format.js  # <-- will render `app/views/bookings/index.js.erb`
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.room_id = params[:roomtype]
    # update bookings stripe payment plan. Which is room.stripe_product.find_pricing_plan
    # retrieve all plans of room.stripe_product = Stripe::Plan.list(product: room.stripe_product)
    if @booking.update(bookings_params)
      flash[:alert] = "Booking successfully updated."
      redirect_to new_booking_contract_path(@booking.booking_auth_token, @booking)
    else
      flash[:alert] = "Oops something went wrong. Please try again."
      redirect_to booking_project_roomtype_path(@booking.booking_auth_token, @booking, @booking.project, @booking.room.roomtype.name)
    end
  end

  def send_booking_process_invite
    booking = Booking.find(params[:id])
    booking.update(booking_auth_token_exp: Date.today+2.weeks)
    UserMailer.invite_for_booking_process(booking)
    booking.update(booking_process_invite_send: true)
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
end

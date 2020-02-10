class RoomsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_booking_auth_token!
  layout "bookingprocess", only: [:index, :show]

  def index
    @booking = Booking.find(params[:booking_id])
    @rooms = find_one_room_of_each_art(params[:project_id])
    @room_availability_hash = find_available_booking_dates_for_each_room_art(@rooms)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(rooms_params)
    if @room.save
      redirect_to @room
    else
      render :new
    end
  end

  def show
    # layout booking
    @booking = Booking.find(params[:booking_id])
    @room = Room.select{|room| room.name.delete(' ').downcase == params[:name].downcase}.first
    @room_availability = {}
    Booking.all.order(:move_out).each { |b| @room_availability.store(b.room.id, (b.move_out + 1.day).strftime('%d.%B %Y')) if b.room.name.delete(' ').downcase == params[:name].downcase && b.state == nil && b.move_out >= Date.today }
    if @room_availability.empty?
      @room_availability.store(@room.id, Date.tomorrow.strftime('%d.%B %Y'))
    end
    # @room_availability = sort_dates(@room_availability)
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(rooms_params)
      flash[:alert] = "Room successfully updated."
      redirect_to @room
    else
      flash[:alert] = "Oops something went wrong. Please try again."
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.delete
      flash[:alert] = "Room successfully deleted."
    else
      flash[:alert] = "Oops something went wrong. Please try again."
    end
    redirect_to rooms_path
  end

  private

  def rooms_params
    params.require(:rooms).permit(
      :project_id,
      :number,
      :name,
      :size,
      :description,
      price: [],
      pictures: []
    )
  end

  def find_one_room_of_each_art(project_id)
    room_names = []
    Project.find(project_id).rooms.each{ |room| room_names << room.name unless room_names.include?(room.name)}
    rooms = []
    room_names.each{ |room_name| rooms << Room.find_by(name: room_name) }
    rooms
  end

  def find_available_booking_dates_for_each_room_art(rooms)
    availability = {}
    rooms.each do |room|
      lastBookingId = Booking.select{ |b| b.room.name.delete(' ').downcase == room.name.delete(' ').downcase && b.state == nil && b.move_out >= Date.today }.last
      if lastBookingId.present?
        availability.store(room.name, (lastBookingId.move_out + 1.day).strftime('%d.%B %Y'))
      else
        availability.store(room.name, 'today')
      end
    end
    availability
  end

  # def sort_dates(dates)
  #   # recursion einbauen
  #   sorted_dates = {}
  #   dates.each_with_index do |(key, first_date), index|
  #     dates.each_value do |comparison_date|
  #       if first_date.to_date <= comparison_date.to_date
  #       end
  #     end
  #   end
  # end
end

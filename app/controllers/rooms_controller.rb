class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]
  before_action :check_booking_auth_token!, only: [:index, :show]
  layout "bookingprocess", only: [:index, :show]

  def index
    @booking = Booking.find(params[:booking_id])
    @rooms = find_one_room_of_each_art(params[:project_id])
    @room_availability_hash = find_available_booking_dates_for_each_room_art(@rooms)
    @project = @rooms.first.project
  end

  def new
    @project = Project.find(params[:project_id])
    # @booking = Booking.find(params[:booking_id])
    @room = @project.rooms.new
  end

  def create
    @room = Room.new(rooms_params)
    if @room.save
      # create_stripe_product_and_plan(@room, @project)
      # create Strpe Product if not yet present
      redirect_to booking_project_room_path(Booking.first, @room.project, @room)
    else
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:booking_id])
    @project = Project.find(params[:project_id])
    @room = @project.rooms.select{|room| room.name.delete(' ').downcase == params[:name].downcase}.first
    @room_availability = {}
    @project.rooms.all.where(name: @room.name).each do |room|
      rooms_last_booking = Booking.all.where(room_id: room.id, state: 'booked').order(:move_out).last
      if rooms_last_booking.present? && rooms_last_booking.move_out >= Date.today
        @room_availability.store(room.id, (rooms_last_booking.move_out + 1.day).strftime('%d.%B %Y')) if !@room_availability.values.include?((rooms_last_booking.move_out + 1.day).strftime('%d.%B %Y'))
      else
        @room_availability.store(room.id, Date.tomorrow.strftime('%d.%B %Y')) if !@room_availability.values.include?(Date.tomorrow.strftime('%d.%B %Y'))
      end
    end

    @room_availability = @room_availability.sort_by { |key, value| value.to_date }.to_h
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
      pictures: [],
      room_amenities_attributes: [:amenity_id]
    )
  end

  def find_one_room_of_each_art(project_id)
    room_names = []
    project = Project.find(project_id)
    project.rooms.order(:size).each{ |room| room_names << room.name unless room_names.include?(room.name)}
    rooms = []
    room_names.each{ |room_name| rooms << project.rooms.find_by(name: room_name) }
    rooms
  end

  def find_available_booking_dates_for_each_room_art(rooms)
    availability = {}
    rooms.each do |room|
      lastBookingId = Booking.select{ |b| b.state == 'booked' && b.move_out >= Date.today && b.room.name.delete(' ').downcase == room.name.delete(' ').downcase if b.room.present? }.last
      if lastBookingId.present?
        availability.store(room.name, (lastBookingId.move_out + 1.day).strftime('%d.%B %Y'))
      else
        availability.store(room.name, 'today')
      end
    end
    availability
  end

  def create_stripe_product_and_plan(room, project)
    product = Stripe::Product.create(
      name: "#{room.name.capitalize} #{project.name}",
      statement_descriptor: "STACEY Rent",
      type: 'service'
    )
    room.price.each_with_index do |price, index|
      if index.zero?
        text = '3-5'
      elsif index == 1
        text = '6-8'
      else
        text = '9+'
      end
      Stripe::Plan.create(
        product: product.id,
        amount: price * 100,
        interval: 'month',
        nickname: "#{room.name} Rent for #{text} Months",
        currency: "eur"
      )
    end
  end
end

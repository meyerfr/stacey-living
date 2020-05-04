class RoomtypesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]
  before_action :check_booking_auth_token!, only: [:index, :show]
  layout "bookingprocess", only: [:index, :show]

  def index
    @booking = Booking.find(params[:booking_id])
    @roomtypes = find_one_roomtype_of_each_art(params[:project_id])
    @room_availability_hash = find_available_booking_dates_for_each_room_art(@roomtypes)
    @project = @roomtypes.first.project
  end

  def new
    @project = Project.find(params[:project_id])
    @amenities = Amenity.all
    # @booking = Booking.find(params[:booking_id])
    @roomtype = @project.roomtypes.new
  end

  def create
    @roomtype = Roomtype.new(rooms_params)
    if @roomtype.save
      # create_stripe_product_and_plan(@roomtype, @project)
      # create Strpe Product if not yet present
      redirect_to booking_project_roomtype_path(Booking.first, @roomtype.project, @roomtype)
    else
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:booking_id])
    @project = Project.find(params[:project_id])
    @roomtype = @project.roomtypes.select{|type| type.name.delete(' ').downcase == params[:name].delete(' ').downcase}.first
    @room_availability = {}
    @project.roomtypes.all.where(name: @roomtype.name).first.room_attributes.each do |room_attribute|
      rooms_last_booking = Booking.all.where(room_attribute_id: room_attribute.id, state: 'booked').order(:move_out).last
      if rooms_last_booking.present? && rooms_last_booking.move_out >= Date.today
        @room_availability.store(room_attribute.id, (rooms_last_booking.move_out + 1.day).strftime('%d.%B %Y')) if !@room_availability.values.include?((rooms_last_booking.move_out + 1.day).strftime('%d.%B %Y'))
      else
        @room_availability.store(room_attribute.id, Date.tomorrow.strftime('%d.%B %Y')) if !@room_availability.values.include?(Date.tomorrow.strftime('%d.%B %Y'))
      end
    end

    @room_availability = @room_availability.sort_by { |key, value| value.to_date }.to_h
  end

  def edit
    @roomtype = Roomtype.find(params[:id])
  end

  def update
    @roomtype = Roomtype.find(params[:id])
    if @roomtype.update(rooms_params)
      flash[:alert] = "Room successfully updated."
      redirect_to @roomtype
    else
      flash[:alert] = "Oops something went wrong. Please try again."
      render :edit
    end
  end

  def destroy
    @roomtype = Roomtype.find(params[:id])
    if @roomtype.delete
      flash[:alert] = "Room successfully deleted."
    else
      flash[:alert] = "Oops something went wrong. Please try again."
    end
    redirect_to roomtypes_path
  end

  private

  def roomtypes_params
<<<<<<< HEAD:app/controllers/roomtypes_controller.rb
    params.require(:roomtypes).permit(
=======
    params.require(:rooms).permit(
>>>>>>> 370d8f0... changed every room variable to roomtype:app/controllers/rooms_controller.rb
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

  def find_one_roomtype_of_each_art(project_id)
    room_names = []
    project = Project.find(project_id)
    project.roomtypes.order(:size).each{ |type| room_names << type.name unless room_names.include?(type.name)}
    roomtypes = []
    room_names.each{ |room_name| roomtypes << project.roomtypes.find_by(name: room_name) }
    roomtypes
  end

  def find_available_booking_dates_for_each_room_art(rooms)
    availability = {}
    roomtypes.each do |type|
      lastBookingId = Booking.select{ |b| b.state == 'booked' && b.move_out >= Date.today && b.room_attribute.roomtype.name.delete(' ').downcase == type.name.delete(' ').downcase if b.room_attribute.present? }.last
      if lastBookingId.present?
        availability.store(type.name, (lastBookingId.move_out + 1.day).strftime('%d.%B %Y'))
      else
        availability.store(type.name, 'today')
      end
    end
    availability
  end

  def create_stripe_product_and_plan(room, project)
    product = Stripe::Product.create(
      name: "#{roomtype.name.capitalize} #{project.name}",
      statement_descriptor: "STACEY Rent",
      type: 'service'
    )
    roomtype.price.each_with_index do |price, index|
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
        nickname: "#{roomtype.name} Rent for #{text} Months",
        currency: "eur"
      )
    end
  end
end

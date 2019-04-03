class RoomsController < ApplicationController
  def index
    @flat = Flat.find(params[:flat_id])
    @rooms = Room.all.where(flat_id: @flat.id)
  end

  def show
    @user = User.first
    @flat = Flat.find(params[:flat_id])
    @room = Room.find(params[:id])
    @booking = Booking.new
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.flat_id = params[:flat_id]
    @room.user_id = 1
    @flat = Flat.find(params[:flat_id])
    if @room.save!
      redirect_to flat_room_path(@flat, @room)
    else
      render :new
    end
  end

  def edit
    @flat = Flat.find(params[:flat_id])
    @room = Room.find(params[:id])
  end

  def update
    @flat = Flat.find(params[:flat_id])
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to flat_room_path(@flat, @room)
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.destroy
      redirect_to rooms_path
    else
      render :edit
    end
  end

  private

  def room_params
    params.require(:room).permit(:art_of_room, :availability, :user_id, :balcony, :flat_id, :room_size, :description, {pictures: []}, price: [], deposit: [])
  end
end

class BookingsController < ApplicationController
  before_action :authenticate_user_for_contract_booking_pages!, only: [:new]
  before_action :authenticate_user_for_contract_pages!, only: [:create]
  before_action :authenticate_admin!, only: [:index, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :create, :update, :success, :contract]

  def create
    @booking = Booking.new(booking_params)
    @user = User.find(@booking.user_id)
    @authentity_token_contract = params[:authentity_token_contract]
    if @booking.save
      # redirect to 2nd Contract Page (PDF page)
      redirect_to booking_contract_new_path(@booking, @authentity_token_contract)
    else
      render :new
    end
  end

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to @booking
    else
      render :edit
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      redirect_to bookings_path
    else
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :room_id)
  end
end

class BookingsController < ApplicationController
  before_action :authenticate_user_for_bookings, only: [:create]
  before_action :authenticate_admin!, only: [:index, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :show, :create, :update, :success, :contract]

  # def new
  #   @booking = Booking.new
  #   @rooms = Room.all
  #   @user = User.first
  #   @flat = Flat.first
  # end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      # redirect to 2nd Contract Page (PDF page)
      redirect_to bookings_path
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
    params.require(:booking).permit(:user, :room)
  end

  def authenticate_user_for_bookings
    user = User.find(params[:id])
    if user.authentity_token_contract == params[:authentity_token_contract]
      if !user.authentity_token_contract_expiration.future?
        flash[:alert] = "FUCK YOU"
        redirect_to new_user_path
      end
    else
      flash[:alert] = "Your not allowed to access this page"
      redirect_to new_user_path
    end
  end
end

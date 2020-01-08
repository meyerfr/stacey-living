class BookingsController < ApplicationController
  def calendar
    @bookings = Booking.all
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.room_id = params[:room]
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
end

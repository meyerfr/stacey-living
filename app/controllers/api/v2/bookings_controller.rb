class Api::V2::BookingsController < Api::V2::WebhooksController
  before_action :set_booking

  def complete_booking
    if booking.update(bookings_params)
      booking = booking.as_json.merge({
        project: booking.project,
        user: booking.user,
        roomtype: booking.roomtype,
        room: booking.room
      })

      render json: booking
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end
end

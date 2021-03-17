class Api::V2::BookingsController < Api::V2::WebhooksController
  before_action :set_booking

  def update
    @booking.update!(bookings_params)

    user = @booking.user
    user = user.attributes.merge({
      address: user.address #? user.address : user.build_address(street: '', country: '', city: '', zip: '')
    })

    @booking = @booking.attributes.merge({
      user: user,
      project: @booking.project,
      roomtype: @booking.roomtype,
      room: @booking.room,
      price: @booking.price
    })

    render json: @booking
  end

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

  def bookings_params
    params.require(:booking).permit(
      :move_in,
      :move_out,
      :price_id,
      :room_id,
      :state
    )
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end

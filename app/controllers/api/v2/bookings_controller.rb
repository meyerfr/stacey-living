class Api::V2::BookingsController < Api::V2::WebhooksController
  before_action :set_booking, except: [ :complete_booking ]

  def create
    user = User.find(params[:user_id])
    application = user.application
    booking = user.bookings.new(
      state: 'invite send',
      booking_auth_token: Devise.friendly_token,
      booking_auth_token_exp: Date.today+2.weeks,
      pipedrive_deal_id: application.pipedrive_deal_id
    )
    # booking.user.skip_password_validation = true
    if booking.save!
      # send invite to Booking Process
      BookingMailer.invite_for_booking_process(booking).deliver_now
      render json: booking
      # redirect_to new_booking_welcome_call_path(booking.booking_auth_token, booking)
    else
      render json: booking.errors
    end
  end

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
    booking = Booking.find(params[:booking_id])
    booking.booking_process_completed_date = Date.today
    if booking.update(bookings_params)
      RestClient.put(
        pipedrive_api_url("deals/#{booking.pipedrive_deal_id}"),
        {
          "stage_id": 14,
        }.to_json,
        {content_type: :json, accept: :json}
      )

      BookingMailer.booking_process_completed(booking).deliver_now

      booking = booking.as_json.merge({
        project: booking.project,
        user: booking.user,
        roomtype: booking.roomtype,
        room: booking.room,
        price: booking.price
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

  def pipedrive_api_url(action)
    "https://api.pipedrive.com/v1/#{action}?api_token=#{ENV['PIPEDRIVE_API_TOKEN']}"
  end
end

class PaymentsController < ApplicationController
  def calendar
    @bookings = Booking.all
  end

  def new
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
    @booking = Booking.find(params[:booking_id])
  end

  def create
  end

  private

  def payments_params
    params.require(:order).permit(:stripeSource)
  end
end

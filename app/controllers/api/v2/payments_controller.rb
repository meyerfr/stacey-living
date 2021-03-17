class Api::V2::PaymentsController < ActionController::Base
  before_action :set_booking
  def new
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

    booking = Booking.find(params[:booking_id])

    customer = create_or_retrieve_stripe_customer(booking.user)

    intent = Stripe::PaymentIntent.create({
      amount: 8000,
      currency: 'eur',
      metadata: {integration_check: 'accept_a_payment'},
      setup_future_usage: 'off_session',
      customer: customer['id']
    })
    render json: {client_secret: intent.client_secret}
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def create_or_retrieve_stripe_customer(user)
    if user.stripe_id?
      customer = Stripe::Customer.retrieve(user.stripe_id)
    else
      customer = Stripe::Customer.create(name: user.full_name, email: user.email)
      user.update(stripe_id: customer.id)
    end
    return customer
  end
end

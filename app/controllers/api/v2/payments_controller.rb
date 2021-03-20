class Api::V2::PaymentsController < ActionController::Base
  before_action :set_booking
  def new
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

    booking = Booking.find(params[:booking_id])

    customer = create_or_retrieve_stripe_customer(booking.user)

    # payment_method = retrieve_payment_method(customer['id'])

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

  # def retrieve_payment_method(customer_id)
  #   payment_methods = Stripe::PaymentMethod.list({
  #                       customer: customer_id,
  #                       type: 'card',
  #                     })
  #   payment_methods.count > 1 ? payment_methods.first : false
  # end
end

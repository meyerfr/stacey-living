class Api::V1::PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :secret ]
  before_action :check_booking_auth_token!, only: [ :secret ]

	def secret
		Stripe.api_key = 'sk_test_pblbbDNQnHAALD1MrdaNtOx6'

		booking = Booking.find(params[:booking_id])
		user = booking.user
		if user.stripe_id?
      customer = Stripe::Customer.retrieve(user.stripe_id)
    else
      customer = Stripe::Customer.create(name: user.full_name, email: user.email)
      user.update(stripe_id: customer.id)
    end

		intent = Stripe::PaymentIntent.create({
		  amount: 8000,
		  currency: 'eur',
		  # Verify your integration in this guide by including this parameter
		  metadata: {integration_check: 'accept_a_payment'},
		  customer: customer.id
		})
		render json: {client_secret: intent.client_secret}
	end
end

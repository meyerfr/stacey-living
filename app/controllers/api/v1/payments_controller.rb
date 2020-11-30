class Api::V1::PaymentsController < ActionController::Base
	def secret
		Stripe.api_key = 'sk_test_pblbbDNQnHAALD1MrdaNtOx6'

		booking = Booking.find(params[:booking_id])
		user = booking.user
		customer = if user.stripe_id?
	              Stripe::Customer.retrieve(user.stripe_id)
	             else
	              Stripe::Customer.create(name: user.full_name, email: user.email)
	             end

		intent = Stripe::PaymentIntent.create({
		  amount: 1099,
		  currency: 'eur',
		  # Verify your integration in this guide by including this parameter
		  metadata: {integration_check: 'accept_a_payment'},
		  customer: customer.id
		})
		render json: {client_secret: intent.client_secret}
	end
end

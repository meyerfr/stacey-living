class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_booking_auth_token!, :set_booking, :set_price_and_deposit
  layout "bookingprocess", only: [:new]

  def new
    # layout booking
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
    # @list = Stripe::Customer.list()
  end

  def create
    # find or create customer
    # charge booking fee 80€
    # charge deposit one week before move in (booking.room.price[])
    # create subscription:
    #   trial_period until move_in
    #   cancels on move_out
    #   item: [{ plan: booking.stripe_billing_plan}]
    raise

    customer = find_or_create_stripe_customer(@user)

    stripe_product = Stripe::Product.retrieve(@roomtype.stripe_product)
    # assumed stripe_plan exists, need function if it doesn´t
    plan = find_stripe_plan(@booking, @roomtype, stripe_product)

    # Charge Booking Fee
    chargeBookingFee = Stripe::Charge.create({
      amount: (@booking_fee * 100),
      currency: 'eur',
      customer: customer.id,
      source: params[:stripeSource],
      description: "Booking Fee"
    })

    chargeDeposit = Stripe::Charge.create({
      amount: (@price.to_i * 2 * 100),
      currency: 'eur',
      customer: customer.id,
      source: params[:stripeSource],
      description: "Deposit"
    })

    # Subscription to User for rent
    subscription = Stripe::Subscription.create({
      # what´s the billing cycle?
      customer: customer.id,
      collection_method: "charge_automatically",
      cancel_at: @booking.move_out.to_time.to_i,
      items: [{ plan: plan }],
      trial_end: (@booking.move_in - 2.days).to_time.to_i
    })

    @booking.update(state: 'booked')
    redirect_to users_success_path
    # redirect_to booking_path(@booking)
    rescue Stripe::CardError => e
      flash[:alert] = e.message
  end

  private

  def payments_params
    params.require(:order).permit(:stripeSource)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
  end

  def set_price_and_deposit
    @roomtype = @booking.room_attribute.roomtype
    move_in = @booking.move_in
    move_out = @booking.move_out
    duration = (move_out.year - move_in.year) * 12 + move_out.month - move_in.month - (move_out.day >= move_in.day ? 0 : 1)
    if duration <= 5
      @price = @roomtype.price[0]
    # this eleif only comes in place if we make deposit = @price * 3 when duration > 8
    # elsif duration <= 8
    #   @price = @roomtype.price[1]
    #   @deposit = @price * 2
    else
      @price = @roomtype.price[2]
    end
    @booking_fee = 80
    @total_today = @booking_fee + (@price * 2)
    # @total_amount = @deposit + 80
  end

  def find_stripe_plan(booking, room, product)
    duration = ((booking.move_out - booking.move_in).to_i) / 29
    if duration < 4
      duration_string = '3-5'
    elsif duration < 8
      duration_string = '6-8'
    else
      duration_string = '9+'
    end
    Stripe::Plan.list({ product: product.id }).data.each do |p|
      return p if p.nickname == "Basic Rent for #{duration_string} Months"
    end
  end

  def find_or_create_stripe_customer(user)
    customer = Stripe::Customer.list({ email: user.email }).data.reduce(:+)
    unless customer.present?
      customer = Stripe::Customer.create(
        source: params[:stripeSource],
        email: user.email,
        name: user.full_name
      )
    end
    return customer
  end
end

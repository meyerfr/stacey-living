class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]
  before_action :check_booking_auth_token!
  before_action :set_booking
  before_action :set_price_and_deposit, except: [:new, :create, :create_payment_intent]
  layout "overview", only: [:new]

  def new
  end

  def create_payment_intent
    content_type 'application/json'
    data = params[:items]
    # data = JSON.parse(request.body.read)
    payment_intent = Stripe::PaymentIntent.create(
      amount: calculate_price(data['items']),
      currency: 'eur'
    )
    {
      clientSecret: payment_intent['client_secret'],
    }.to_json
    return payment_intent
  end

  def create
    # find or create customer
    # charge booking fee 80€
    # charge deposit one week before move in (booking.room.price[])
    # create subscription:
    #   trial_period until move_in
    #   cancels on move_out
    #   item: [{ plan: booking.stripe_billing_plan}]

    # Stripe.api_key = ENV('STRIPE_SECRET_KEY')
    # plan_id = 'plan_Fod9NFfUPmzUn5'
    raise
    roomtype = @booking.roomtype
    plan = Stripe::Plan.retrieve('plan_G2SvVfE4hiTNAd')
    # find plan = Stripe::Plan.retrieve(correct_price.stripe_plan_id)

    # product = Stripe::Product.retrieve(roomtype.stripe_product_id)

    token = params[:stripeToken]

    customer = if @user.stripe_id?
                Stripe::Customer.retrieve(@user.stripe_id)
               else
                Stripe::Customer.create(name: @user.full_name, email: @user.email)
               end

    unless Stripe::PaymentMethod.list({customer: customer.id, type: 'card'}).count.positve?
      Stripe::PaymentMethod.create({
        type: 'card',
        card: {
          number: params[:user],
          exp_month: 7,
          exp_year: 2021,
          cvc: '314',
        },
        customer: customer.id
      })
    end

    roomtype_prices = roomtype.prices.order(amount: :desc)
    correct_price = case @booking.duration
                    when 3..5
                      roomtype_prices.first
                    when 6..8
                      roomtype_prices.second
                    else
                      roomtype_prices.last
                    end

    deposit = correct_price.amount.to_i*2
    # charge customer for bookingFee and the Deposit
    # charge = Stripe::Charge.create({
    #   amount: (deposit + 80)*100, # 80€ BookingFee
    #   currency: 'eur',
    #   description: 'STACEY - BookingFee and Deposit',
    #   source: token,
    # })

    # Create subscription for the roomtype
    subscription = customer.subscriptions.create(plan: plan.id)

    options = {
      stripe_id: customer.id,
      stripe_subscription_id: subscription.id,
      subscribed: true
    }

    options.merge!(
      card_last4: params[:user][:card_last4],
      card_exp_month: params[:user][:card_exp_month],
      card_exp_year: params[:user][:card_exp_year],
      card_type: params[:user][:card_type]
    ) if params[:user][:card_last4]

    @user.update(options)

    redirect_to root_path, notice: 'Your subscription was setup successfully!'

    # customer = find_or_create_stripe_customer(@user)

    # stripe_product = Stripe::Product.retrieve(@roomtype.stripe_product)
    # # assumed stripe_plan exists, need function if it doesn´t
    # plan = find_stripe_plan(@booking, @roomtype, stripe_product)

    # # Charge Booking Fee
    # chargeBookingFee = Stripe::Charge.create({
    #   amount: (@booking_fee * 100),
    #   currency: 'eur',
    #   customer: customer.id,
    #   source: params[:stripeSource],
    #   description: "Booking Fee"
    # })

    # chargeDeposit = Stripe::Charge.create({
    #   amount: (@price.to_i * 2 * 100),
    #   currency: 'eur',
    #   customer: customer.id,
    #   source: params[:stripeSource],
    #   description: "Deposit"
    # })

    # # Subscription to User for rent
    # subscription = Stripe::Subscription.create({
    #   # what´s the billing cycle?
    #   customer: customer.id,
    #   collection_method: "charge_automatically",
    #   cancel_at: @booking.move_out.to_time.to_i,
    #   items: [{ plan: plan }],
    #   trial_end: (@booking.move_in - 2.days).to_time.to_i
    # })

    # @booking.update(state: 'booked')
    # redirect_to users_success_path
    # # redirect_to booking_path(@booking)
    # rescue Stripe::CardError => e
    #   flash[:alert] = e.message
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

  def calculate_price(_items)
    # Booking.find(items[:id])
  end
end

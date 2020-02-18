class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_booking_auth_token!, :set_booking, :set_price_and_deposit
  layout "bookingprocess", only: [:new]

  def calendar
    @bookings = Booking.all
  end

  def new
    # layout booking
    @phone_code = %w(+61 +43 +32 +55 +1 +86 +45 +358 +33 +49 +852 +353 +39 +81 +352 +52 +31 +64 +47 +351 +65 +34 +46 +41 +44)
    # @list = Stripe::Customer.list()
  end

  def create
    customer = find_stripe_customer(@user)

    unless customer.present?
      customer = Stripe::Customer.create(
        source: params[:stripeSource],
        email: @user.email,
        name: @user.full_name
      )
    end

    product = find_stripe_product(@room, @room.project)

    # assumed stripe_plan exists, need function if it doesn´t
    plan = find_stripe_plan(@booking, product)

    # Charge Booking Fee and Depoit
    charge = Stripe::Charge.create({
      amount: (@deposit + 80) * 100,
      currency: 'eur',
      customer: customer.id,
      source: params[:stripeSource],
      description: "Booking Fee and Depoit"
    })

    # Subscription to User for rent
    subscription = Stripe::Subscription.create({
      # what´s the billing cycle?
      customer: customer.id,
      billing: "charge_automatically",
      cancel_at: @user.duration_of_stay.to_time.to_i,
      items: [{ plan: plan }],
      trial_end: @user.move_in_date.to_time.to_i
    })

    @booking.update(state: 'booked')
    redirect_to users_success_path
    # redirect_to booking_path(@booking)
    rescue Stripe::CardError => e
      flash[:alert] = e.message
    raise
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
    @room = @booking.room
    move_in = @booking.move_in
    move_out = @booking.move_out
    duration = (move_out.year - move_in.year) * 12 + move_out.month - move_in.month - (move_out.day >= move_in.day ? 0 : 1)
    if duration <= 5
      @price = @room.price[0]
      @deposit = @price * 2
    # this eleif only comes in place if we make deposit = @price * 3 when duration > 8
    # elsif duration <= 8
    #   @price = @room.price[1]
    #   @deposit = @price * 2
    else
      @price = @room.price[2]
      @deposit = @price * 2
    end
    @total_amount = @deposit + 80
  end

  def find_stripe_product(room, flat)
    Stripe::Product.list.data.each do |p|
      return p if p.name == "#{room.art_of_room} #{flat.street}"
    end
  end

  def find_stripe_plan(user, room, product)
    duration = ((user.duration_of_stay - user.move_in_date).to_i) / 29
    if duration < 4
      duration_string = '3-5'
    elsif duration < 8
      duration_string = '6-8'
    else
      duration_string = '9+'
    end
    Stripe::Plan.list({ product: product.id }).data.each do |p|
      return p if p.nickname == "#{room.art_of_room} Rent for #{duration_string} Months"
    end
  end

  def find_stripe_customer(customer)
    return Stripe::Customer.list({ email: customer.email }).data.reduce(:+)
  end
end

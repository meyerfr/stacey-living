class PaymentsController < ApplicationController
  before_action :set_booking
  before_action :set_price_and_deposit
  layout 'booking'
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @phone_code = []
    IsoCountryCodes.all.each do |country|
      @phone_code << country.calling
    end
  end

  def create
    Stripe.api_key = 'sk_test_pblbbDNQnHAALD1MrdaNtOx6'

    # Find Customer if existing
    correct_customer = find_stripe_customer

    unless correct_customer.present?
      correct_customer = Stripe::Customer.create(
        source: params[:stripeSource],
        email:  @applicant.email,
        name: "#{@applicant.first_name} #{@applicant.last_name}"
      )
    end

    # Find correct Product for this Room
    correct_product = find_stripe_product(@room, @room.flat)

    correct_plan = find_stripe_plan

    # Charge Booking Fee and Depoit
    charge = Stripe::Charge.create({
      amount: (@deposit + 80) * 100,
      currency: 'eur',
      customer: correct_customer.id,
      source: params[:stripeSource],
      description: "Booking Fee and Depoit"
    })

    # Subscription to Applicant for rent

    subscription = Stripe::Subscription.create({
      # what´s the billing cycle?
      customer: correct_customer.id,
      billing: "charge_automatically",
      cancel_at: (@applicant.duration_of_stay[0].to_i.month + 1.month).to_time.to_i,
      items: [{ plan: correct_plan }],
      trial_end: @applicant.move_in_date.to_time.to_i
    })

    # Subscription to User for billing Fee
    # billing_fee_subscription = Stripe::Subscription.create({
    #   customer: correct_customer.id,
    #   billing_cycle_anchor: Time.now.getutc.to_i,
    #   items: [{ plan: 'plan_FCkWhQFQ09s5uo'}]
    # })

    # Stripe: once Booking Fee: 90 Euro
    # Stripe: new Subscription for every new Booking

    # charge = Stripe::Charge.create(
    #   type: 'sepa_debit',
    #   customer:     customer.id, # You should store this customer id and re-use it.
    #   amount:       ,
    #   description:  "Payment for Renting #{@booking.room.art_of_room} for order #{@booking.id}",
    #   currency:     'eur'
    # )
    @booking.update(payment: charge.to_json, state: 'paid')
    redirect_to users_success_path
    # redirect_to booking_path(@booking)
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    raise
  end

  private

  def payment_params
    params.require(:order).permit(:stripeSource)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
    @applicant = @booking.user
  end

  def set_price_and_deposit
    @applicant = User.find(@booking.user_id)
    @room = Room.find(@booking.room_id)
    if @applicant.duration_of_stay[0].to_i < 4
      @amount_per_month = @room.price[0]
      @deposit = @room.price[0]
    elsif @applicant.duration_of_stay[0].to_i < 8
      @amount_per_month = @room.price[1]
      @deposit = @room.price[1] * 2
    else
      @amount_per_month = @room.price[2]
      @deposit = @room.price[2] * 3
    end
    @total_amount = @deposit + 80
  end

  def find_stripe_product(room, flat)
    Stripe::Product.list.data.each do |p|
      return p if p.name == "#{room.art_of_room} #{flat.street}"
    end
  end

  def find_stripe_plan
    if @applicant.duration_of_stay[0].to_i < 4
      @duration_string = '3-5'
    elsif @applicant.duration_of_stay[0].to_i < 8
      @duration_string = '6-8'
    else
      @duration_string = '9+'
    end
    Stripe::Plan.list.data.each do |p|
      return p if p.nickname = "#{@room.art_of_room} Rent for #{@duration_string} Months"
    end
  end

  def find_stripe_customer
    Stripe::Customer.list.data.each do |c|
      return c if c.email == @applicant.email
    end
  end
end

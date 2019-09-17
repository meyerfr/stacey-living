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
    correct_customer = ''
    Stripe::Customer.list.data.each do |c|
      correct_customer = c if c.email == @applicant.email
    end
    unless correct_customer.present?
      correct_customer = Stripe::Customer.create(
        source: params[:stripeSource],
        email:  @applicant.email,
        name: "#{@applicant.first_name} #{@applicant.last_name}"
      )
    end

    # Charge Booking Fee
    # charge = Stripe::Charge.create({
    #   amount: 9000,
    #   currency: 'eur',
    #   customer: correct_customer.id,
    #   source: params[:stripeSource],
    #   description: "Booking Fee"
    # })

    # Find correct Product for this Room
    correct_product = ''
    Stripe::Product.list.data.each do |p|
      correct_product = p if p.name == @room.art_of_room
    end

    # Create Plans
    deposit_plan = Stripe::Plan.create({
      amount: @deposit * 100,
      interval: 'month',
      product: correct_product.id,
      currency: 'eur',
      nickname: "Deposit of #{@applicant.first_name} #{@applicant.last_name}"
    })

    # Rent Plans
    rent_plan = Stripe::Plan.create({
      amount: @amount_per_month * 100,
      interval: 'month',
      product: correct_product.id,
      currency: 'eur',
      nickname: "Rent of #{@applicant.first_name} #{@applicant.last_name}"
    })

    # Subscription to Applicant for rent

    subscription_rent = Stripe::Subscription.create({
      customer: correct_customer.id,
      billing: "charge_automatically",
      billing_cycle_anchor: @applicant.move_in_date.to_time.to_i,
      cancel_at: (@applicant.duration_of_stay + 1.month).to_time.to_i,
      items: [
        {
          plan: rent_plan
        }
      ]
    })

    # Subscription to Applicant for Deposit
    subscription_deposit = Stripe::Subscription.create({
      customer: correct_customer.id,
      billing: "charge_automatically",
      billing_cycle_anchor: @applicant.move_in_date.to_time.to_i,
      cancel_at: (@applicant.move_in_date + 1.day).to_time.to_i,
      items: [
        {
          plan: deposit_plan
        }
      ]
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
    @booking.update(state: 'paid')
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
    duration = ((@applicant.duration_of_stay - @applicant.move_in_date).to_i) / 29
    if duration < 4
      @amount_per_month = @room.price[0]
      @deposit = @room.price[0]
    elsif duration < 8
      @amount_per_month = @room.price[1]
      @deposit = @room.price[1] * 2
    else
      @amount_per_month = @room.price[2]
      @deposit = @room.price[2] * 3
    end
    @total_amount = 80
  end
end

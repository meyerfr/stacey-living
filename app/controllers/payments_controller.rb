class PaymentsController < ApplicationController
  before_action :set_booking
  before_action :set_price_and_deposit
  layout 'booking'
  def new
    @phone_code = []
    IsoCountryCodes.all.each do |country|
      @phone_code << country.calling
    end
  end

  def create
    Stripe.api_key = 'sk_test_pblbbDNQnHAALD1MrdaNtOx6'
    customer = Stripe::Customer.create(
      source: params[:stripeSource],
      email:  Booking.find(params[:booking_id]).user.email
    )

    charge = Stripe::Charge.create({
      amount: 90,
      currency: 'eur',
      customer: customer,
      source: params[:stripeSource],
      description: "Renting Fee"
    })

    # charge = Stripe::Charge.create(
    #   type: 'sepa_debit',
    #   customer:     customer.id, # You should store this customer id and re-use it.
    #   amount:       ,
    #   description:  "Payment for Renting #{@booking.room.art_of_room} for order #{@booking.id}",
    #   currency:     'eur'
    # )
    redirect_to users_success_path
    @booking.update(payment: charge.to_json, state: 'paid')
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
    @total_amount = (@amount_per_month * @applicant.duration_of_stay[0].to_i) + @deposit
  end
end

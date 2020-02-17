class ContractsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_booking_auth_token!
  layout "bookingprocess", only: [:new]

  def new
    # layout booking
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @room = @booking.room
    @project = @room.project
    @contract = @booking.contracts.new

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Contract #{@user.first_name} #{@user.last_name}",
        page_size: 'A4',
        template: "contracts/_contract.html.erb",
        layout: "pdf.html",
        zoom: 1
      end
    end
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @user.update(contracts_params[:user_attributes])
    @contract = Contract.new(contracts_params.except(:user_attributes))
    @contract.booking_id = @booking.id
    if @contract.save
      redirect_to booking_contract_path(@booking.booking_auth_token, @booking, @contract)
    else
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:booking_id])
    @contract = @booking.contracts.last
    @user = @booking.user
    @room = @booking.room
    @flat = @room.project
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Contract #{@user.first_name} #{@user.last_name}",
        page_size: 'A4',
        template: "contracts/_pdf.html.erb",
        layout: "pdf.html",
        zoom: 1
      end
    end
  end

  private

  def contracts_params
    params.require(:contract).permit(:signature, :signed_date, user_attributes: [:street, :city, :zipcode, :country])
  end
end

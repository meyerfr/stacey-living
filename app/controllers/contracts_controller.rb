class ContractsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:contract]
  before_action :check_booking_auth_token!, only: [:contract]
  layout "bookingprocess", only: [:new, :show]
  layout "overview", only: [:contract]

  def new
    # layout booking
    @booking = Booking.find(params[:booking_id])
    @user = @booking.user
    @room = @booking.room
    @roomtype = @room.roomtype
    @project = @roomtype.project
    @contract = @booking.contract.present? ? @booking.contract : @booking.build_contract
    @countries = ['Australia', 'Austria', 'Belgium', 'Brazil', 'United States', 'China', 'Denmark', 'Finland', 'France', 'Germany', 'Hong Kong', 'Ireland', 'Italy', 'Japan', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Portugal', 'Singapore', 'Spain', 'Sweden', 'Switzerland', 'United Kingdom']
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Contract #{@user.first_name} #{@user.last_name}",
        page_size: 'A4',
        template: "contracts/_contract.html.erb",
        layout: "pdf.html",
        zoom: 0.8
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
      @booking.contracts.first.delete if @booking.contracts.length > 1
      redirect_to booking_contract_path(@booking.booking_auth_token, @booking, @contract)
    else
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:booking_id])
    @contract = @booking.contract
    @user = @booking.user
    @room = @booking.room
    @roomtype = @room.roomtype
    @project = @roomtype.project
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Contract #{@user.first_name} #{@user.last_name}",
        page_size: 'A4',
        template: "contracts/_contract.html.erb",
        layout: "pdf.html",
        zoom: 0.8
      end
    end
  end

  def contract
    # render json: contract
  end

  private

  def contracts_params
    params.require(:contract).permit(:signature, :signed_date, user_attributes: [:street, :city, :zipcode, :country])
  end
end

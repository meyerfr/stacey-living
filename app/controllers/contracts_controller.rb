class ContractsController < ApplicationController
  before_action :authenticate_user_for_contract_pages!, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [:new, :create]
  layout 'booking'

  def new
    @user = User.find(params[:user_id])
    @room = Room.find(params[:room_id])
    @flat = Flat.find(params[:flat_id])
    @contract = Contract.new
    @booking = Booking.create(user: @user, room: @room)
    @authentity_token_contract = params[:authentity_token_contract]

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Contract No. #{@contract.id}",
        page_size: 'A4',
        template: "contracts/_pdf.html.erb",
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end

  def create
    @contract = Contract.new(contract_params)
    @booking = params[:booking_id]
    @authentity_token_contract = params[:authentity_token_contract]
    if @contract.save!
      redirect_to contract_path(@contract, @authentity_token_contract)
    else
      render :new
    end
  end

  def show
    @contract = Contract.find(params[:contract_id])
    @booking = Booking.find(@contract.booking_id)
    @user = User.find(@booking.user_id)
    @room = Room.find(@booking.room_id)
    @flat = Flat.find(@room.flat_id)
    @authentity_token_contract = params[:authentity_token_contract]
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Contract No. #{@contract.id}",
        page_size: 'A4',
        template: "contracts/_pdf.html.erb",
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end

  def update
    @contract = Contract.find(params[:contract_id])
    @authentity_token_contract = params[:authentity_token_contract]
    @contract.update(contract_params)
    redirect_to contract_path(@contract, @authentity_token_contract)
  end
  # def payment

  # end
  private

  def contract_params
    params.require(:contract).permit(:booking_id, :signature, :signed_on)
  end
end

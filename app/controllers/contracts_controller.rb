class ContractsController < ApplicationController
  before_action :authenticate_user_for_contract_pages, only: [:rooms_show, :room_detail_show, :contract_pdf, :payment]
  skip_before_action :authenticate_user!, only: [:rooms_show, :room_detail_show, :contract_pdf, :payment]

  def rooms_show
    @rooms = Room.all
    @user = User.find(params[:user_id])
    @flat = Flat.first
    @authentity_token_contract = params[:authentity_token_contract]
  end

  def room_detail_show
    @room = Room.find(params[:room_id])
    @user = User.find(params[:user_id])
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.create!(user_id: @user.id, room_id: @room.id)
    @contract = Contract.create!(booking_id: @booking.id)
    @authentity_token_contract = params[:authentity_token_contract]
  end

  def contract_pdf
    @contract = Contract.find(params[:id])
    @booking = Booking.find(@contract.booking_id)
    @user = User.find(@booking.user_id)
    @room = Room.find(@booking.room_id)
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
        zoom: 2.5,
        dpi: 75
      end
    end
  end

  # def payment

  # end

  private

  # def contract_params
  #   params.require(:contract).permit(:flat, :room, :user)
  # end

  def authenticate_user_for_contract_pages
    user = User.find(params[:user_id])
    if user.authentity_token_contract == params[:authentity_token_contract]
      if !user.authentity_token_contract_expiration.future?
        flash[:alert] = "Please SignIn first"
        redirect_to new_user_path
      end
    else
      flash[:alert] = "Your not allowed to access this page"
      redirect_to new_user_path
    end
  end
end

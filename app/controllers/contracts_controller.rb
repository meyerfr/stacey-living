class ContractsController < ApplicationController
  before_action :authenticate_user_for_contract_pages, only: [:rooms_show, :room_detail_show, :contract_pdf, :payment]
  skip_before_action :authenticate_user!, only: [:rooms_show, :room_detail_show, :contract_pdf, :payment]

  def rooms_show
    @rooms = Room.all
    @user = User.find(params[:id])
    @flat = Flat.first
    @authentity_token_contract = params[:authentity_token_contract]
  end

  def room_detail_show
    @room = Room.find(params[:room_id])
    @user = User.find(params[:id])
    @flat = Flat.find(params[:flat_id])
    @authentity_token_contract = params[:authentity_token_contract]
  end

  # def contract_pdf

  # end

  # def payment

  # end

  private

  # def contract_params
  #   params.require(:contract).permit(:flat, :room, :user)
  # end

  def authenticate_user_for_contract_pages
    user = User.find(params[:id])
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

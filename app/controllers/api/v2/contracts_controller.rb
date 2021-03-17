class Api::V2::ContractsController < ActionController::Base
  def create
    booking = Booking.find(params[:booking_id])
    contract = booking.build_contract(contracts_params)
    contract.save!
    render json: contract
  end

  private

  def contracts_params
    params.require(:contract).permit(
      :signature,
      :signed_date
    )
  end
end

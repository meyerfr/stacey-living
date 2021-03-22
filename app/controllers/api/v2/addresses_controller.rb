class Api::V2::AddressesController < ActionController::Base
  def create
    user = User.find(params[:user_id])
    address = user.build_address(addresses_params)
    address.save!
    render json: address
  end

  private

  def addresses_params
    params.require(:address).permit(
      :street,
      :city,
      :country,
      :zip
    )
  end
end

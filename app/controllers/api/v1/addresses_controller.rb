class Api::V1::AddressesController < ActionController::Base

	def create
		user = User.find(params[:user_id])
		address = user.create_address(addresses_params)

		render json: address
	end

	def update
		address = Address.find(params[:id])
		address.update!(addresses_params)
		render json: address
	end

	private

	def addresses_params
	  params.require(:address).permit(:street, :number, :city, :country, :zip)
	end

end

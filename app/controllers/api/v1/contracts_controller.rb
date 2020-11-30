class Api::V1::ContractsController < ActionController::Base
	def update
		# booking = Booking.find(params[:booking_id])
		contract = Contract.find(params[:id])
		booking = contract.booking
		contract.signature = params[:signature]
		contract.signed_date = Date.today
		contract.save!

   	user = booking.user
    roomtype = booking.roomtype
    project = roomtype.project

    contract = contract.as_json.merge(
    	{
				move_in: booking.move_in,
				move_out: booking.move_out,
				user: {
					id: user.id,
					first_name: user.first_name,
					last_name: user.last_name,
					dob: user.dob,
					address: user.address ? user.address : nil,
				},
				price_per_month: 100,
				roomtype_name: roomtype.name,
				project_address: project.address.address
			}
    )

		render json: contract
	end

	def index
		booking = Booking.find(params[:booking_id])
		contract = booking.contract ? booking.contract : booking.build_contract

   	user = booking.user
    roomtype = booking.roomtype
    project = roomtype.project

    contract = contract.as_json.merge(
    	{
				move_in: booking.move_in,
				move_out: booking.move_out,
				user: {
					id: user.id,
					first_name: user.first_name,
					last_name: user.last_name,
					dob: user.dob,
					address: user.address ? user.address : nil,
				},
				price_per_month: 100,
				roomtype_name: roomtype.name,
				project_address: project.address.address
			}
    )

		render json: contract
	end

	# def show
	# 	booking = Booking.find(params[:booking_id])
	# 	contract = params[:id] ? Contract.find(params[:id]) : booking.build_contract
 #   	user = booking.user
 #    room = booking.room
 #    roomtype = room.roomtype
 #    project = roomtype.project

 #    contract = contract.as_json.merge({room: room, user: user, booking: booking, roomtype: roomtype, project: project})

	# 	render json: contract
	# end

	private

	def contracts_params
	  params.require(:contract).permit(:signature)
	end

end

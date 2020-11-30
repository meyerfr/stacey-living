class Api::V1::UsersController < ActionController::Base
	def update
		user = User.find(params[:id])
		user.update!(users_params)
		render json: user
	end

	private

	def users_params
	  params.require(:user).permit(
	  	:first_name,
      :last_name,
      :email,
      :phone_code,
      :phone_number,
      :dob,
      :job,
      :gender,
      :amount_of_people
    )
	end

end

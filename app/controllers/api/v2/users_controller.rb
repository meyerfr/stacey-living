class Api::V2::UsersController < ActionController::Base
  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update!(users_params)

    user = user.attributes.merge({
      address: user.address #? user.address : user.build_address(street: '', country: '', city: '', zip: '')
    })
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
      :gender,
      :amount_of_people
    )
  end
end

class Api::V1::ApplicationsController < ActionController::Base

  def create
    user = User.find_by(email: applications_params[:user_attributes][:email])
    if user.present?
      application = user.build_application(applications_params.except(:user_attributes))
    else
      application = Application.new(applications_params)
      application.user.skip_password_validation = true
    end

    if application.save!
      UserMailer.welcome(application.user).deliver_later(wait_until:  2.minutes.from_now)
      render json: application
      # redirect_to new_booking_welcome_call_path(booking.booking_auth_token, booking)
    else
      render json: application.errors
    end
  end


  private

  def applications_params
    params.require(:application).permit(
      :move_in,
      :move_out,
      :prefered_suite,
      :prefered_location,
      user_attributes: [
        :first_name,
        :last_name,
        :email,
        :dob,
        :phone_code,
        :phone_number
      ]
    )
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :authenticate_admin!

  def authenticate_admin!
    return unless !current_user.admin?
    redirect_back(fallback_location: root_path)
  end

  def authenticate_user_for_contract_pages!
    if !current_user.admin?
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

  def authenticate_user_for_contract_booking_pages!
    user = User.find(Booking.find(params[:booking_id]).user_id)
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

  protected

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name])
  end
end

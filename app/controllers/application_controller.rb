class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def check_booking_auth_token!
    unless current_user&.admin?
      booking = Booking.find(params[:booking_id])
      if booking.booking_auth_token == params[:booking_auth_token]
        unless booking.booking_auth_token_exp.future?
          flash[:alert] = "This link has expired, please request a renewal."
          redirect_to root_path unless current_user&.admin?
        end
      else
        flash[:alert] = "You don´t have access to the page. Maybe wrong url."
        redirect_to root_path
      end
    end
  end
end

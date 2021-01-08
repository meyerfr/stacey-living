class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_call.subject
  #
  before_action :set_logo_attachment

  # welcome is beeing send after sign up if welcome_call has not been scheduled
  def welcome(booking)
    @booking = booking
    @user = @booking.user
    if WelcomeCall.find_by(booking_id: @booking.id)
      message.perform_deliveries = false
    else
      email_with_name = %("#{@user.full_name}" <#{@user.email}>)
      mail(to: email_with_name, subject: 'Stacey - coliving')
    end
  end

  private

  def set_logo_attachment
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/stacey_logo_pink.png")
  end
end

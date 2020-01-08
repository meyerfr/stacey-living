class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_call.subject
  #
  before_action :set_logo_attachment

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

  def welcome_call(welcome_call)
    @welcome_call = welcome_call
    @booking = @welcome_call.booking
    @user = @booking.user
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Stacey - coliving - Call invitation')
  end

  def welcome_call_rescheduled(welcome_call)
    @welcome_call = welcome_call
    @booking = @welcome_call.booking
    @user = @booking.user
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Stacey - coliving - welcome call')
  end

  private

  def set_logo_attachment
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/stacey_logo_pink.png")
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_call
  def welcome_call
    UserMailer.welcome_call(WelcomeCall.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_call_rescheduled
  def welcome_call_rescheduled
    UserMailer.welcome_call(WelcomeCall.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    UserMailer.welcome(Booking.first)
  end
end

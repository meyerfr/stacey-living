# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_call
  def welcome_call
    UserMailer.welcome_call(WelcomeCall.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_call_rescheduled
  def welcome_call_rescheduled
    UserMailer.welcome_call(WelcomeCall.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    UserMailer.welcome(Booking.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/invite_for_booking_process
  def invite_for_booking_process
    UserMailer.invite_for_booking_process(Booking.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_one_pager
  def welcome_one_pager
    UserMailer.welcome_one_pager(Booking.last)
  end
end

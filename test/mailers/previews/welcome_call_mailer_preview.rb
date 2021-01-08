# Preview all emails at http://localhost:3000/rails/mailers/welcome_call_mailer
class WelcomeCallMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/welcome
  def welcome(booking)
    BookingMailer.welcome(Booking.where(state: nil).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/welcome_call
  def welcome_call(booking)
    BookingMailer.welcome_call(Booking.where(state: nil).take)
  end
  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/welcome_call_rescheduled
  def welcome_call_rescheduled(booking)
    BookingMailer.welcome_call_rescheduled(Booking.where(state: nil).take)
  end
end

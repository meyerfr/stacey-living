# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/invite_for_booking_process
  def invite_for_booking_process
    BookingMailer.invite_for_booking_process(Booking.where.not(booking_auth_token: nil).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/booking_process_reminder
  def booking_process_reminder
    BookingMailer.booking_process_reminder(Booking.where.not(booking_auth_token: nil).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/booking_process_completed
  def booking_process_completed
    BookingMailer.booking_process_completed(Booking.where(state: ['deposit outstanding']).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/deposit_received
  def deposit_received
    BookingMailer.deposit_received(Booking.where(state: ['booked']).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/deposit_not_received
  def deposit_not_received
    BookingMailer.deposit_not_received(Booking.where(state: ['deposit outstanding', 'bookingFee payment failed']).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/welcome_one_pager
  def welcome_one_pager
    BookingMailer.welcome_one_pager(Booking.where(state: ['booked']).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/extend_booking
  def extend_booking
    BookingMailer.extend_booking(Booking.where(state: ['booked']).take)
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/rate_booking
  def rate_booking
    BookingMailer.rate_booking(Booking.where(state: ['booked']).take)
  end
end

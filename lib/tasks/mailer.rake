desc "This task is called by the Heroku scheduler add-on every day"
task :send_mails => :environment do
  puts "send booking process reminder"
  to_be_reminded_bookings = Booking.where(created_at: [Date.today - 5.days, Date.today - 10.days], state: ['deposit outstanding', 'bookingFee payment failed'])
  to_be_reminded_bookings.each do |booking|
    BookingMailer.booking_process_reminder(booking)
  end


  # to send notive that deposit has not been received after 2 days after the booking process has been completed, I need a variabel: booking_process_completed_on
  not_received_deposit_bookings = Booking.where("booking_process_completed_date = ? AND state = ?", Date.today - 2.days, 'deposit outstanding')
  not_received_deposit_bookings.each do |booking|
    BookingMailer.deposit_not_received(booking)
  end

  puts "send welcome to STACEY community"
  to_be_welcomed_bookings = Booking.where(state: 'booked', move_in: Date.today + 7.days)
  to_be_welcomed_bookings.each do |booking|
    BookingMailer.welcome_one_pager(booking)
  end

  puts "send request to extend booking"
  to_be_extended_bookings = Booking.where(state: 'booked', move_out: Date.today + 1.month)
  to_be_extended_bookings.each do |booking|
    BookingMailer.extend_booking(booking)
  end

  puts "send request to rate stay"
  to_be_rated_bookings = Booking.where(state: 'booked', move_out: Date.today + 7.days)
  to_be_rated_bookings.each do |booking|
    BookingMailer.rate_booking(booking)
  end

  puts "send_mails job done"
end

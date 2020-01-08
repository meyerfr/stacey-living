class AddBookingAuthTokenToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :booking_auth_token, :string
    add_column :bookings, :booking_auth_token_exp, :date
  end
end

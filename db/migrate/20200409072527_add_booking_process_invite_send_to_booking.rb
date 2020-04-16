class AddBookingProcessInviteSendToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :booking_process_invite_send, :boolean, default: false
  end
end

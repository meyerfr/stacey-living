class ChangeColumnNameInBookings < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookings, :booking_process_invite_send, :booking_process_completed_date
  end
end

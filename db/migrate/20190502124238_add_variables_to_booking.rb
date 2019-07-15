class AddVariablesToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :state, :string, default: 'pending'
    add_column :bookings, :payment, :jsonb
  end
end

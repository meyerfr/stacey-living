class AddAttributesToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :monthly_price, :float
    add_column :prices, :stripe_plan_id, :string
  end
end

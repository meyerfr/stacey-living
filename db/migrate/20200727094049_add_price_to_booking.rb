class AddPriceToBooking < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookings, :price, foreign_key: true
  end
end

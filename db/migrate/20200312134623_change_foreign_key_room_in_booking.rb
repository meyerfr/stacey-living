class ChangeForeignKeyRoomInBooking < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bookings, :room, index: true, foreign_key: true
    add_reference :bookings, :room_attribute, index: true
    add_foreign_key :bookings, :room_attributes
  end
end

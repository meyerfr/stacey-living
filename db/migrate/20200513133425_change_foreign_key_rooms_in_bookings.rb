class ChangeForeignKeyRoomsInBookings < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :bookings, :room_attribute_id
    add_reference :bookings, :room, index: true
  end

  def self.down
    remove_column :bookings, :room_id
    add_reference :bookings, :room_attribute, index: true
  end
end

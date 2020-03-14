class ChangeForeignKeyBookingInRoomAttributes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :room_attributes, :booking, index: true, foreign_key: true
    add_reference :room_attributes, :room, index: true
    add_foreign_key :room_attributes, :rooms
  end
end

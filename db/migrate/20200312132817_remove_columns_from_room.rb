class RemoveColumnsFromRoom < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bookings, :room, index: true, foreign_key: true
    add_reference :bookings, :room, index: true
    add_foreign_key :bookings, :rooms
    remove_column :rooms, :number
    remove_column :rooms, :house_number
  end
end

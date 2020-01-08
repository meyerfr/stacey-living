class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.date :move_in
      t.date :move_out
      t.string :state

      t.timestamps
    end
  end
end

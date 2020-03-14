class CreateRoomAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :room_attributes do |t|
      t.string :number
      t.string :house_number
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end

class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :price, array: true, default: []
      t.string :art_of_room
      t.boolean :balcony
      t.string :room_size
      t.text :description
      t.integer :deposit, array: true, default: []
      t.json :pictures
      t.references :flat, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

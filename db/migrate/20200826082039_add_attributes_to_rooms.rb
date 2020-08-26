class AddAttributesToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :apartment_number, :string
    add_column :rooms, :state, :string
  end
end

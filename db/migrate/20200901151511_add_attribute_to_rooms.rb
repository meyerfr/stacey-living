class AddAttributeToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :bookable_date, :date
  end
end

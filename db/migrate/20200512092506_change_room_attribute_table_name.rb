class ChangeRoomAttributeTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :room_attributes, :rooms
    rename_column :rooms, :number, :intern_number
  end
end

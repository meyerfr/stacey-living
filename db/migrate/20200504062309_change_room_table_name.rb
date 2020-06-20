class ChangeRoomTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :rooms, :roomtypes
  end
end

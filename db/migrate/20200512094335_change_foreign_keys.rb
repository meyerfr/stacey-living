class ChangeForeignKeys < ActiveRecord::Migration[5.2]
  def self.up
    # change foreign_key in room_table (old: room_attribute) room.id to roomtype.id
    remove_column :rooms, :room_id
    add_reference :rooms, :roomtype, index: true
    # change foreign_key in room_amenities_table room.id to roomtype.id
    remove_column :room_amenities, :room_id
    add_reference :room_amenities, :roomtype, index: true
  end

  def self.down
    remove_column :rooms, :roomtype_id
    add_reference :rooms, :room, index: true
    remove_column :room_amenities, :roomtype_id
    add_reference :room_amenities, :room, index: true
  end
end

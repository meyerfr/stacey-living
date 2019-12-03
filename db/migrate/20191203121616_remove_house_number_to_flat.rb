class RemoveHouseNumberToFlat < ActiveRecord::Migration[5.2]
  def change
    remove_column :flats, :house_number, :string
  end
end

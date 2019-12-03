class AddHouseNumberToFlat < ActiveRecord::Migration[5.2]
  def change
    add_column :flats, :house_number, :string
  end
end

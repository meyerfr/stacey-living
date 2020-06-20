class AddGeocodeAttributesToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :longitude, :float
    add_column :addresses, :latitude, :float
    add_index :addresses, [:latitude, :longitude]
  end
end

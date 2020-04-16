class AddTypeToAmenity < ActiveRecord::Migration[5.2]
  def change
    add_column :amenities, :type, :string
  end
end

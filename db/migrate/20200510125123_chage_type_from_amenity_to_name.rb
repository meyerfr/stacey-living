class ChageTypeFromAmenityToName < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :amenities, :type, :name
  end

  def self.down
    rename_column :amenities, :name, :type
  end
end

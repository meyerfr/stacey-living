class CreateJoinAmenities < ActiveRecord::Migration[5.2]
  def change
    create_table :join_amenities do |t|
      t.references :amenitiable, polymorphic: true
      t.string :name
      t.references :amenity, foreign_key: true

      t.timestamps
    end
  end
end

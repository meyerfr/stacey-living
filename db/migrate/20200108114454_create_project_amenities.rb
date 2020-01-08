class CreateProjectAmenities < ActiveRecord::Migration[5.2]
  def change
    create_table :project_amenities do |t|
      t.references :amenity, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

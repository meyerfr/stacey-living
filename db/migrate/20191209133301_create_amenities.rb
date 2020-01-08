class CreateAmenities < ActiveRecord::Migration[5.2]
  def change
    create_table :amenities do |t|
      t.string :icon_text
      t.string :title

      t.timestamps
    end
  end
end

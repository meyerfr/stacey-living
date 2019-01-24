class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.string :street
      t.integer :zipcode
      t.string :city
      t.timestamps
    end
  end
end

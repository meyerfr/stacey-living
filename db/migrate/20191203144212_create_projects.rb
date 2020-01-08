class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :street
      t.string :house_number
      t.string :city
      t.integer :zipcode
      t.string :name
      t.text :description
      t.json :pictures

      t.timestamps
    end
  end
end

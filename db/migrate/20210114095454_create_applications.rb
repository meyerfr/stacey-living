class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :move_in
      t.string :move_out
      t.string :prefered_location
      t.string :prefered_suite
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

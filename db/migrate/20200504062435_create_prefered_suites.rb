class CreatePreferedSuites < ActiveRecord::Migration[5.2]
  def change
    create_table :prefered_suites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :roomtype, foreign_key: true, null: false

      t.timestamps
    end
  end
end

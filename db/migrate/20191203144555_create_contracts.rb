class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :booking, foreign_key: true
      t.binary :signature
      t.date :signed_date

      t.timestamps
    end
  end
end

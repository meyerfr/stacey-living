class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.string :duration
      t.float :amount
      t.references :roomtype, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSignatures < ActiveRecord::Migration[5.2]
  def change
    create_table :signatures do |t|
      t.binary :signature

      t.timestamps
    end
  end
end

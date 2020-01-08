class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :phone_code
      t.string :phone
      t.text :message

      t.timestamps
    end
  end
end

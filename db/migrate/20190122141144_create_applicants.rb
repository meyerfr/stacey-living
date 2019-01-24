class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.date :date_of_birth
      t.string :job
      t.date :move_in_date
      t.string :duration_of_stay
      t.integer :amount_of_people
      t.timestamps
    end
  end
end

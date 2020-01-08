class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, default: 'applicant'
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dob, :date
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :zipcode, :integer
    add_column :users, :country, :string
    # add_column :users, :move_in, :date
    # add_column :users, :move_out, :date
    add_column :users, :instagram, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :linkedin, :string
    add_column :users, :job, :string
    add_column :users, :amount_of_people, :integer, default: 1
    add_column :users, :gender, :string, array: true
    add_column :users, :prefered_suite, :string, array: true
    add_column :users, :phone_number, :string
    add_column :users, :phone_code, :string
    add_column :users, :photo, :string
  end
end

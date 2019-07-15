class AddEverythingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_code, :string
    add_column :users, :phone, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :job, :string
    add_column :users, :move_in_date, :date
    add_column :users, :duration_of_stay, :string
    add_column :users, :amount_of_people, :string
    add_column :users, :description, :text
    add_column :users, :admin, :boolean, default: false
    add_column :users, :applicant, :boolean, default: true
    add_column :users, :photo, :string
    add_column :users, :instagram, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :linked_in, :string
    add_column :users, :authentity_token_contract, :string
    add_column :users, :authentity_token_contract_expiration, :date
  end
end

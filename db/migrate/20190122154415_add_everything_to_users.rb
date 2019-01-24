class AddEverythingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :job, :string
    add_column :users, :move_in_date, :date
    add_column :users, :duration_of_stay, :string
  end
end

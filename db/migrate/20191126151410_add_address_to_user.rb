class AddAddressToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :zipcode, :integer
    add_column :users, :country, :string
  end
end

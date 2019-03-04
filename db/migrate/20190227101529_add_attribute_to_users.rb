class AddAttributeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :photo, :string
    add_column :users, :instagram, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :linked_in, :string
  end
end

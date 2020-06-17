class AddAmountOfPeopleToRoomtypes < ActiveRecord::Migration[5.2]
  def change
    add_column :roomtypes, :amount_of_people, :integer, default: 1
  end
end

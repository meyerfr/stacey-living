class ChangeDurationOfStayToDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :duration_of_stay, :string
    add_column :users, :duration_of_stay, :date
  end
end

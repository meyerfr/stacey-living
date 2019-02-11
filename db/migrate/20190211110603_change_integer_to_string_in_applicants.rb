class ChangeIntegerToStringInApplicants < ActiveRecord::Migration[5.2]
  def change
    change_column :applicants, :amount_of_people, :string
  end
end

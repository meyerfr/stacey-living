class AddPhoneCodeToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :phone_code, :string
  end
end

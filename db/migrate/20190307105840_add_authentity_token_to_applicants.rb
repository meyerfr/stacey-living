class AddAuthentityTokenToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :authentity_token_contract, :string
    add_column :applicants, :authentity_token_contract_expiration, :date
  end
end

class AddPreferedSuiteToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prefered_suite, :string, array: true, default: ["Basic", "Premium", "Jumbo"]
  end
end

class ChangeDefaultOfPreferedSuite < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :prefered_suite, nil)
  end
end

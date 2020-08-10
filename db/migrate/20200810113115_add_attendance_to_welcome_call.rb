class AddAttendanceToWelcomeCall < ActiveRecord::Migration[5.2]
  def change
    add_column :welcome_calls, :attendance, :boolean
  end
end

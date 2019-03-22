class AddProjectNameToFlats < ActiveRecord::Migration[5.2]
  def change
    add_column :flats, :project_name, :string
  end
end

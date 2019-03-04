class AddLinkedInToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :linked_in, :string
    add_column :applicants, :instagram, :string
    add_column :applicants, :twitter, :string
    add_column :applicants, :facebook, :string
  end
end

class AddAttributeInvitedToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :invited, :boolean
  end
end

class AddPipedriveAttributesToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pipedrive_person_id, :integer
    add_column :applications, :pipedrive_deal_id, :integer
    add_column :bookings, :pipedrive_deal_id, :integer
  end
end

class DatabaseUpdateForBookingProcess < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :amenities, :name
    remove_column :amenities, :icon_text
    remove_column :bookings, :booking_process_invite_send
    add_column :bookings, :booking_process_invite_send, :date, default: nil
    drop_table :project_amenities
    drop_table :room_amenities
    remove_column :projects, :street
    remove_column :projects, :house_number
    remove_column :projects, :city
    remove_column :projects, :zipcode
    remove_column :projects, :description
    remove_column :projects, :pictures
    remove_column :roomtypes, :price
    remove_column :roomtypes, :description
    remove_column :roomtypes, :pictures
    remove_column :users, :street
    remove_column :users, :city
    remove_column :users, :zipcode
    remove_column :users, :country
    remove_column :users, :instagram
    remove_column :users, :facebook
    remove_column :users, :twitter
    remove_column :users, :linkedin
    remove_column :users, :prefered_suite
    remove_column :users, :photo
    change_column :projects, :status, :string, default: 'inactive'
  end

  def self.down
    add_column :amenities, :name
    add_column :amenities, :icon_text
    remove_column :bookings, :booking_process_invite_send, :boolean, default: :false
    change_column :bookings, :booking_process_invite_send, :boolean
    create_table :project_amenities do |t|
      t.references :amenity, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
    create_table :room_amenities do |t|
      t.references :amenity, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
    add_column :projects, :street, :string
    add_column :projects, :house_number, :string
    add_column :projects, :city, :string
    add_column :projects, :zipcode, :integer
    add_column :projects, :descriptions, :text
    add_column :projects, :pictures, :json
    add_column :roomtypes, :price, :float
    add_column :roomtypes, :description, :text
    add_column :roomtypes, :pictures, :json
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :zipcode, :integer
    add_column :users, :country, :string
    add_column :users, :instagram, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :linkedin, :string
    add_column :users, :prefered_suite, :string
    add_column :users, :photo, :json
    change_column :projects, :status, :string, default: nil
  end
end


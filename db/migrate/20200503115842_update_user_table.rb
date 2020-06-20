class UpdateUserTable < ActiveRecord::Migration[5.2]
  def self.up
    change_column :users, :gender, :string, array: false, default: nil, using: "(array_to_string(gender, ','))"
    say_with_time "Updating users..." do
      User.all.each do |u|
        u.social_links.create(name: 'Facebook', url: u.facebook) if u.facebook.present?
        u.social_links.create(name: 'Instagram', url: u.instagram) if u.instagram.present?
        u.social_links.create(name: 'LinkedIn', url: u.linkedin) if u.linkedin.present?
        u.social_links.create(name: 'Twitter', url: u.twitter) if u.twitter.present?
      end
    end
  end

  def self.down
    change_column :users, :gender, :string, array: true, default: [], using: "(string_to_array(mobile_number, ','))"
    social_links.destroy_all
  end
end

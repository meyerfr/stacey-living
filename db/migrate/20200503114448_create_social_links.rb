class CreateSocialLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :social_links do |t|
      t.string :name
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
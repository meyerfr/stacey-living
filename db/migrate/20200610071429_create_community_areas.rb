class CreateCommunityAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :community_areas do |t|
      t.references :project, foreign_key: true
      t.string :name
      t.float :size

      t.timestamps
    end
  end
end

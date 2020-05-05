class CreateDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptions do |t|
      t.references :descriptionable, polymorphic: true, index: { name: 'index_descs_on_descable_type_and_descable_id' }
      t.string :field
      t.text :content

      t.timestamps
    end
  end
end

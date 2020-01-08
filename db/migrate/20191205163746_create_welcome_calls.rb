class CreateWelcomeCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :welcome_calls do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.references :booking, foreign_key: true
      t.boolean :available, default: true
    end
  end
end

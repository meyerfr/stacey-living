class AddSignatureToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :signature, :binary
    add_column :contracts, :signed_on, :date
  end
end

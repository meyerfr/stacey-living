class AddStripeAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :stripe_product, :string
    add_column :bookings, :stripe_billing_plan, :string
  end
end

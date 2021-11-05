class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.integer :postage
      t.integer :billing_amount
      t.integer :method_of_payment, default: 0, null: false
      t.string  :name
      t.string  :shipping_address
      t.string  :shipping_postal_code
      t.integer :order_status, default: 0, null: false

      t.timestamps
    end
  end
end

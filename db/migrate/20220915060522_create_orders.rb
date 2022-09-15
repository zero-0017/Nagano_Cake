class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :total_price
      t.integer :payment_method, default: 0
      t.integer :postage
      t.string :shipping_post_code
      t.string :shipping_address
      t.string :shipping_name
      t.integer :status, default: 0
      t.timestamps
    end
  end
end

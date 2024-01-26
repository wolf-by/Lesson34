class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|

      t.integer :number
      t.text :title
      t.decimal :price
      t.integer :quantity
      t.decimal :total_price
      t.integer :total_quantity
      t.text :name_client
      t.text :phone_client
      t.text :address_client

      t.timestamps
    end
  end
end

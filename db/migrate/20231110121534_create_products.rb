class CreateProducts < ActiveRecord::Migration[7.1]
  def change
  
    create_table :products do |t|

      t.string :title
      t.text :description
      t.string :path_to_image
      t.decimal :price
      t.decimal :size
      t.boolean :is_spicy
      t.boolean :is_veg
      t.boolean :is_best_offer
      t.integer :quantity
    
      t.timestamps
    end
      
  end
end

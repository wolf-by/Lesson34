class AddProducts < ActiveRecord::Migration[7.1]
  def change
  
    Product.create :title => 'Hawaiian', :description => 'This is Hawaiian pizza', :path_to_image => '/images/hawaiian.jpg', :price => 350, :size => 32, :is_spicy => false, :is_veg => false, :is_best_offer => true, :quantity => 1
    Product.create :title => 'Pepperoni', :description => 'This is Pepperoni pizza', :path_to_image => '/images/pepperoni.jpg', :price => 450, :size => 32, :is_spicy => false, :is_veg => false, :is_best_offer => true, :quantity => 1
    Product.create :title => 'Veg', :description => 'This is Veg pizza', :path_to_image => '/images/hawaiian.jpg', :price => 500, :size => 32, :is_spicy => false, :is_veg => true, :is_best_offer => false, :quantity => 1

  end
end
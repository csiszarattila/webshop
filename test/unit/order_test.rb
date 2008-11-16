require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	
  test "add items from cart" do
		cart = Cart.new()
		[:marple_book, :bob_dvd, :keane_cd].each { |name| cart.add_product(products(name)) }
		order = Order.new()
		order.add_items_from_cart(cart)
		
		assert_not_nil order.items
		assert_equal cart.items.size, order.items.size
		assert_equal cart.total_price, order.total_price
  end
end

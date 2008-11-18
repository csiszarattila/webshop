require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	
  test "add items from cart" do
		cart = Cart.new()
		[:marple_book, :bob_dvd, :keane_cd].each { |name| cart.add_product(products(name)) }
		order = Order.new()
		order.add_items_from_cart(cart)
		
		assert_not_nil order.items
		assert_equal cart.items.size, order.items.size
  end

	test "create order with order type new" do
		cart = Cart.new()
		[:marple_book, :bob_dvd, :keane_cd].each { |name| cart.add_product(products(name)) }
		order = Order.new(:order_type => OrderType.first)
		order.add_items_from_cart(cart)
		
		assert_valid(order)
		assert_not_nil order.order_state
		assert_equal OrderState.find_by_name("Újak"), order.order_state
	end
end

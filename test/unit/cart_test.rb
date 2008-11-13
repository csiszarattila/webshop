require 'test_helper'

class CartTest < ActiveSupport::TestCase
	
	def setup
		@cart = Cart.new()
		@lego = products(:lego)
		@marple_book = products(:marple_book)
	end
	
	test "add products to cart" do
		@cart.add_product(@marple_book)
		@cart.add_product(@lego)
		assert_equal 2, @cart.items.size
		assert_equal @lego.price + @marple_book.price, @cart.total_price
	end
	
	# Ugyanaz a termék hozzáadása a mennyiséget növeli
	test "add same product multiple times" do
		@cart.add_product(@lego)
		@cart.add_product(@lego)
		
		assert_equal 1, @cart.items.size
		assert_equal 2, @cart.items[0].quantity
		assert_equal 2*@lego.price, @cart.total_price
	end
	
	test "remove product from cart" do
		@cart.add_product(@lego)
		@cart.add_product(@lego)
		
		@cart.remove_product(@lego.id)
		assert_equal 1, @cart.items.size
		assert_equal 1, @cart.items[0].quantity
		assert_equal 1*@lego.price, @cart.total_price
	end
	
	test "add n times then remove n times" do
		add_n_times = 45
		remove_n_times = 26
		
		add_n_times.times do |n|
			@cart.add_product(@lego)
		end
		remove_n_times.times do |n|
			@cart.remove_product(@lego.id)
		end
		
		assert_equal (add_n_times-remove_n_times), @cart.items[0].quantity
		assert_equal (add_n_times-remove_n_times)*@lego.price, @cart.total_price
	end
	
	# 1 db esetén a mennyiség csökkentése kiveszi a terméket
	test "when quantity is 1 removing is destroying cart item" do
		@cart.add_product(@lego)
		@cart.add_product(@marple_book)
		
		@cart.remove_product(@lego.id)
		assert_equal 1, @cart.items.size
		assert !@cart.items.include?(@lego), "Cart content was: #{@cart.items.collect{|item| item.product.inspect}}"
		assert_equal 1*@marple_book.price, @cart.total_price
	end
	
	# 1 termek/1db mennyiség esetén a kosár üres lesz
	test "destroy when only 1 product in cart with quantity 1 is emptying cart" do
		@cart.add_product(@lego)
		
		@cart.remove_product(@lego.id)
		assert @cart.items.empty?, "Cart content was: #{@cart.items.collect{|item| item.product.inspect}}"
		assert_equal 0, @cart.total_price
	end
end
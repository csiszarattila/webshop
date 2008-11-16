require 'test_helper'

class CartControllerTest < ActionController::TestCase
	
	def setup
		@sony_tv = products(:sony_tv)
		@keane_cd = products(:keane_cd)
		
		@cart = Cart.new()
		@cart.add_product @sony_tv
		@cart.add_product @sony_tv
		@cart.add_product @keane_cd
	end
	
	test "cart created when first product added" do
		get :add, {:id => Product.first}

		assert_not_nil assigns(:cart)
		assert_not_nil session[:cart]
		assert_redirected_to :show_cart
	end
	
	test "empty cart" do
		get :empty, nil, { :cart => @cart }
		assert_nil session[:cart]
		assert_redirected_to :root
		assert_equal I18n.t('cart.emptied'), flash[:notice]
	end
	
	test "remove product from cart" do
		get :remove, {:id => @sony_tv.id}, {:cart => @cart }
		
		assert_not_nil session[:cart]
		assert_equal 1, session[:cart].items[0].quantity, session[:cart]
		assert_redirected_to :show_cart
	end
	
	test "destroy a cart item" do
		get :destroy, {:id => @sony_tv.id}, {:cart => @cart}
		
		assert_not_nil session[:cart]
		assert_equal 1, session[:cart].items.size, "Cart: #{session[:cart]}"
		assert_redirected_to :show_cart
		assert_equal I18n.t('cart.item.destroyed'), flash[:notice]
	end
	
	test "empty cart if destroyed or removed when one item was in it" do
		get :destroy, {:id => @sony_tv.id}, {:cart => @cart} # remove all items[0]
		get :remove, {:id => @keane_cd.id}, {:cart => @cart} # remove the one items[1]
		
		assert_redirected_to :empty_cart
	end
end

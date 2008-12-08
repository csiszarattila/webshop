require 'test_helper'
require 'test/mocks/zipcode_match.rb'

class OrderControllerTest < ActionController::TestCase
	
	def setup
		@address = addresses(:my_address)
		@customer = customers(:attila_customer)
		@user_id = @customer.user.id
		@order  = Order.new do |o|
			o.order_type = order_types(:no_delivery_with_cash)
			o.notes = "Some notes."
		end
		
		@cart = Cart.new()
		@cart.add_product products(:sony_tv)
		@cart.add_product products(:sony_tv)
		@cart.add_product products(:keane_cd)
		
		@address_to_hash = {
			:zipcode => "#{@address.zipcode}",
			:city => "#{@address.city}",
			:name => "#{@address.name}",
			:tel => "#{@address.tel}",
			:street => "#{@address.street}",
			:email  => "#{@address.email}"
		}#for post
		
		@order_to_hash = {
			:order_type_id => "#{@order.order_type.id}",
			:notes => "#{@order.notes}"
		}#for post
	end
	
	test "set on form customers address if have one" do
		get :address, nil, { :user_id => @user_id }
		
		assert_equal @customer.address, assigns(:address)
		
		get :address, nil, {:user_id => customers(:customer_without_address).id}
		assert_not_nil assigns(:address)
	end
	
	test "order and address added to session when passed validation" do
		post :address, {:address => @address_to_hash, :order => @order_to_hash}, {:user_id => @user_id}
		
		assert_redirected_to :order_confirm
		assert_not_nil session[:address]
		assert_not_nil session[:order]
	end

  test "save address to customer unless has one" do
  	customer = customers(:customer_without_address)
		post :address, {:address => @address_to_hash, :order => @order_to_hash }, {:user_id => customer.user.id}
		
		assert_redirected_to order_confirm_path
		assert_not_nil assigns(:customer)
		assert_not_nil assigns(:customer).address
		assert_equal @address.name, 	assigns(:customer).address.name
		assert_equal @address.city, 	assigns(:customer).address.city
		assert_equal @address.zipcode,assigns(:customer).address.zipcode
		assert_equal @address.tel, 		assigns(:customer).address.tel
		assert_equal @address.street, assigns(:customer).address.street
		assert_equal @address.email, 	assigns(:customer).address.email
  end
	
	test "redirect when no address and order session was set" do
		get :create, nil, {:user_id => @user_id}
		
		assert_redirected_to :root
	end
	
	test "order is created" do
		get :create, nil, { :order => @order, :address => @address, :cart => @cart, :user_id => customers(:peter).user.id }
		
		# sessions destroyed
		assert_nil session[:cart]
		assert_nil session[:address]
		assert_nil session[:order]
		# but customer not
		assert_not_nil session[:user_id]
		# check that all value is stored
		saved_order = Customer.find(@customer.id).orders.first
		assert_not_nil saved_order
		assert_equal @customer, saved_order.customer
		assert_equal @address.name, saved_order.address.name
		assert_equal @address.city, saved_order.address.city
		assert_equal @address.zipcode, saved_order.address.zipcode
		assert_equal @address.tel, saved_order.address.tel
		assert_equal @address.street, saved_order.address.street
		assert_equal @address.email, saved_order.address.email
	end
	
end

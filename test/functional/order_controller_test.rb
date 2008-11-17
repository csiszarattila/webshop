require 'test_helper'

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
		post :address, {:address => @address_to_hash, :order => @order_to_hash }, {:user_id => @user_id}
		
		assert_redirected_to :order_confirm
		assert_not_nil assigns(:customer).address
		assert_equal @address, assigns(:customer).address
  end
	
	test "redirect when no address and order session was set" do
		get :create, nil, {:user_id => @user_id}
		
		assert_redirected_to :root
	end
	
	test "order is created" do
		get :create, nil, {:order=> @order, :address => @address, :user_id => @user_id, :cart => @cart }
		
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
		assert_equal  @address, saved_order.address
	end
	
end

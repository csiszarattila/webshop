require 'test_helper'

class UserControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "login works" do
		user = users(:attila)
		post :login, {:user => {:username => user.username.to_s, :password => "attila"}}, nil
		
		assert_redirected_to :root
		assert_not_nil session[:user_id]
		assert_equal user.id, session[:user_id]
  end

	test "registration" do
		username = "hosszu_nevu_uj_felhasznalo"
		password = "valami"
		post :registration, {:user => { :username => username, :password => password, :password_confirmation => password}}
		
		assert_redirected_to :order_address
		assert_not_nil session[:user_id]
		#check users data through session[:user_id]
		user = User.find(session[:user_id])
		assert_not_nil user
		assert_equal user_groups(:customer), user.group
		assert_not_nil Customer.find_by_user_id(session[:user_id])
	end
	
	test "logout" do
		get :logout, nil, { :user_id => users(:attila).id }
		
		assert_nil session[:user_id]
		assert_redirected_to :root
	end
	
	test "admin login" do
		post :admin_login, {:user => {:username => users(:me).username, :password => "attila"}}
		
		assert_not_nil session[:user_id]
		assert_equal users(:me).id, session[:user_id]
		assert_redirected_to admin_root_path
	end
	
	test "change customer address" do
		@address = addresses(:my_address)
		@address_to_hash = {
			:zipcode => "#{@address.zipcode}",
			:city => "#{@address.city}",
			:name => "#{@address.name}",
			:tel => "#{@address.tel}",
			:street => "#{@address.street}",
			:email  => "#{@address.email}"
		}#for post
		@customer = customers(:peter)
		@user_id = @customer.user.id
		
		post :edit, {:address => @address_to_hash}, {:user_id => @user_id}
		
		assert assigns(:address).valid?
		assert_equal @address.name, @customer.address.name
		assert_equal @address.city, @customer.address.city
		assert_equal @address.zipcode, @customer.address.zipcode
		assert_equal @address.tel, @customer.address.tel
		assert_equal @address.street, @customer.address.street
		assert_equal @address.email, @customer.address.email
	end
	
	test "change user password" do
		@user = users(:peter)
		new_password = "foo"
		post :edit, {:user => {:password => new_password, :password_confirmation => new_password }}, {:user_id => @user.id}
		
		assert assigns(:user).valid?
		assert_not_nil User.authenticate(@user.username,new_password)
	end
end

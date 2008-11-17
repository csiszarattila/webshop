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
end

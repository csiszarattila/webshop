require 'test_helper'

class AdminControllerTest < ActionController::TestCase

	test "logged customer cant access admin" do
		user = users(:peter)
		get admin_orders_path, nil, {:user_id => user.id}
		assert_redirected_to admin_login_path
	end
end
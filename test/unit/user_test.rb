require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@test_user = User.new do |u|
			u.username = "a_random_username"
			u.password = "some random password"
		end
		
		@wrong_user_names = [
			"Péter", #ékezet nem lehet
			"Peter Pal", #szünet karakter nincs 
		]
		
		@accepted_user_names = [
			"123janos",
			"janos123",
			"peter_es_pal",
			"peter_123"] 
	end
	
  test "empty user is invalid" do
		user = User.new()
    assert !user.valid?
		assert user.errors.invalid?(:username)
		assert user.errors.invalid?(:password)
  end

	test "username must be unique" do
		user = @test_user
		user.username = users(:me).username
		assert !user.valid?
		assert user.errors.invalid?(:username)
		assert_equal I18n.translate('activerecord.errors.messages.taken'), user.errors.on(:username)
	end
	
	test "not accepted user names" do
		user = @test_user
		@wrong_user_names.each do |name|
			user.username = name
			assert !user.valid?, "Passed with #{name}"
			assert_equal I18n.translate('activerecord.errors.models.user.attributes.username.invalid'), user.errors.on(:username)
		end
	end
	
	test "accepted user names" do
		user = @test_user
		@accepted_user_names.each do |name|
			user.username = name
			assert_valid(user)
		end
	end
	
	test "create_user and authenticate" do
		password = "attila"
		username = "somelonguniqueusername"
		user = User.new do |u| 
			u.username = username
			u.password = password
		end
		user.save!
		user_auth = User.authenticate(username,password)
		assert_not_nil user
		assert_equal user, user_auth 
	end
	
	test "authenticate" do
    user = User.authenticate("attila","attila")
    assert_not_nil user
    assert_equal user, users(:attila)
  end

	test "create a customer" do
		
		user = User.create_a_customer(@test_user)
		
		assert_not_nil User.find(user.id)
		assert_equal user_groups(:customer), user.group
		assert_not_nil Customer.find_by_user_id(user.id)
	end
end

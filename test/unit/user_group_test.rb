require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
	test "empty usergroup is invalid" do
		user_group = UserGroup.new()
    assert !user_group.valid?
		assert user_group.errors.invalid?(:name)
  end

	test "name must be unique" do
		user_group = UserGroup.new()
		user_group.name = user_groups(:admin).name
		assert !user_group.valid?
		assert user_group.errors.invalid?(:name)
		assert_equal I18n.translate('activerecord.errors.messages.taken'), user_group.errors.on(:name)
	end
end

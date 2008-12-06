require 'test_helper'

class TagTest < ActiveSupport::TestCase

	test "empty label is invalid" do
		tag = Tag.new()
		assert !tag.valid?
		assert tag.errors.invalid?(:name)
	end
	
  test "label must be unique" do
		tag = Tag.new()
		tag.name = tags(:rails).name
		
		assert !tag.valid?
		assert_equal I18n.translate('activerecord.errors.messages.taken'), tag.errors.on(:name)
  end
end

require 'test_helper'

class LabelTest < ActiveSupport::TestCase

	test "empty label is invalid" do
		label = Label.new()
		assert !label.valid?
		assert label.errors.invalid?(:name)
	end
	
  test "label must be unique" do
		label = Label.new()
		label.name = labels(:rails)
		
		assert !label.valid?
		assert_equal I18n.translate('activerecord.errors.messages.taken'), label.errors.on(:name)
  end
end

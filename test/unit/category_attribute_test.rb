require 'test_helper'

class CategoryAttributeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "category attribute cant be blank" do
		attribute = CategoryAttribute.new()
		assert !attribute.valid?
		assert attribute.errors.invalid?(:name)
  end
end

require 'test_helper'

class ProductAttributeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "empty product attribute is invalid" do
		attribute = ProductAttribute.new()
		attribute.category_attribute = category_attributes(:books_author)
    assert !attribute.valid?
		assert attribute.errors.invalid?(:value)
  end
	
	test "value dont have to match if category attribute format empty" do
		attribute = ProductAttribute.new do |pa|
			pa.category_attribute = CategoryAttribute.find(1)
		end
		
		# Format nil value have to accept
		# Formatum nil ertekkel el kell fogadni
		attribute.category_attribute.format = nil
		attribute.value = "foo bar something"
		assert attribute.valid?, "tested with format:nil"
	end
	
	test "value must be match with category attribute format" do
		attribute = ProductAttribute.new do |pa|
			pa.category_attribute = CategoryAttribute.find(1)
		end
		
		# Format - value match
		# formatum - ertek egyeznie kell
		attribute.category_attribute.format = "\w\d"
		attribute.value = "a4"
		assert attribute.valid?, "tested with format: /\w/\d, value: a4"
		
		# Format - value dont match
		# formatum - ertek nem egyeznek
		attribute.category_attribute.format = "\w"
		attribute.value = "4"
		assert !attribute.valid?, "tested with format:/\w, value: 4"
		assert attribute.invalid?(:value)
	end
end

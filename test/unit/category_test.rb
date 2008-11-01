require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "empty category is invalid" do
		category = Category.new()
    assert !category.valid?
		assert category.errors.invalid?(:name)
  end
	
	test "name must be unique in same category level" do
		category = Category.new do |cat|
			cat.parent = categories(:books)
			cat.name = categories(:computer_books).name
		end
		
		assert !category.valid?
		assert I18n.translate('activerecord.errors.messages.category.not_unique_in_same_level')
	end
end

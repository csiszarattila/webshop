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
	
	test "releated_category_ids" do
		test_ids_against = [
			categories(:classic_books).id,
			categories(:classic_books_20th_century).id,
			categories(:books_from_a_to_k).id,
			categories(:books_from_l_to_z).id,
			categories(:classic_books_19th_century).id
		]
		
		assert_equal test_ids_against.sort, categories(:classic_books).releated_category_ids.sort
	end
end

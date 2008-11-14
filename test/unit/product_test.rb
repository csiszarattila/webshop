require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products,:categories
	
	def setup
		#
		# Minta termék, néhány tesztnél nem használhatjuk a fixtures-ket
		# Some test needs sample product other from fixtures
		# 
		@sample_product = Product.new do |p|
			p.name = "Sample product for tests"
			p.category = categories(:books)
			p.price = 2566
		end
	end
	
  test "empty product is invalid" do
		product = Product.new
 		assert !product.valid?
		assert product.errors.invalid?(:name)
		assert product.errors.invalid?(:price)
		assert product.errors.invalid?(:category_id)
  end

	test "category must exists" do
		product = @sample_product
		product.category_id = 100
		assert !product.valid?
		assert product.errors.invalid?(:category_id)
	end
	
	test "price is greater than or equal to 1 forint" do
		product = @sample_product
		# price >= 1
		product.price = 1
		assert product.valid?, product.errors.full_messages
		
		# price = 0
		product.price = 0
		assert !product.valid?
		assert_equal 	I18n.translate('activerecord.errors.messages.greater_than_or_equal_to', :count => 1),
									product.errors.on(:price)
		# price < -1
		product.price = -1
		assert !product.valid?
		assert_equal	I18n.translate('activerecord.errors.messages.greater_than_or_equal_to', :count => 1),
									product.errors.on(:price)
	end
	
	#
	# A price(ár) egész-e 
	# 
	test "price is integer" do
		product = @sample_product
		
		[1.24, 56.24, 5664.24].each do |price|
			product.price = price
			assert !product.valid?, "Tested price value was: #{price}"
			assert_equal 	I18n.translate('activerecord.errors.messages.not_a_number'),
										product.errors.on(:price)
		end
		
		[1, 345, 999, 5444].each do |price|
			product.price = price
			assert product.valid?, "Tested price value was: #{price}"
		end
	end
end

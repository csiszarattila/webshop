class CartItem
	attr_reader :product, :quantity
	
	def initialize(product)
		@product = product
		@quantity = 1
	end
	
	def increment_quantity(quantity=1)
		@quantity += quantity
	end
	
	def decrement_quantity(quantity=1)
		@quantity -= quantity
	end
	
	def price
		@quantity * @product.price
	end
end
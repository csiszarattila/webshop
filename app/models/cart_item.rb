class CartItem
	attr_reader :product_id, :quantity, :price
	
	def initialize(product)
		@product_id = product.id
    @price = product.price
		@quantity = 1
	end
	
	def increment_quantity(quantity=1)
		@quantity += quantity
	end
	
	def decrement_quantity(quantity=1)
		@quantity -= quantity
	end
	
	def price
		@quantity * @price
	end
  
  def product
    Product.find(@product_id)
  end
end
class Cart
	
	def find(id)
		lambda { |item| item.product.id.to_i == id.to_i }
	end
	
	attr_reader :items
	
	def initialize
		@items = []
	end

	def add_product(product)
		current_cart_item = @items.find do |item| item.product == product end
		if current_cart_item.nil?
			@items << CartItem.new(product)
		else
			current_cart_item.increment_quantity
		end
	end
	
	def remove_product(id)
		current_cart_item = @items.find &find(id)
		if current_cart_item.nil?
			raise ActiveRecord::RecordNotFound
		elsif current_cart_item.quantity == 1
			destroy_item(id)
		else
			current_cart_item.decrement_quantity
		end
	end
	
	def destroy_item(id)
		@items.delete_if &find(id)
	end
	
	def total_price
		@items.sum do |item| 
			item.price
		end
	end
end
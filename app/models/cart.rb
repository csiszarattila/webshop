class Cart
	
  attr_reader :items
    	
	def initialize
		@items = []
  end

  def by_product_id(id)
    lambda { |item| item.product_id.to_i == id.to_i }
  end
  
  def find_product(product_id)
    @items.find &by_product_id(product_id)
  end

	def add_product(product)
		current_cart_item = find_product(product.id)
		if current_cart_item.nil?
			@items << CartItem.new(product)
		else
			current_cart_item.increment_quantity
		end
		current_cart_item
	end
	
	def remove_product(id)
		current_cart_item = find_product(id)
		if current_cart_item.nil?
			raise ActiveRecord::RecordNotFound
		elsif current_cart_item.quantity == 1
			destroy_item(id)
		else
			current_cart_item.decrement_quantity
	  end
  
    current_cart_item
	end
	
	def destroy_item(id)
		item = @items.index &by_product_id(id)
		raise ActiveRecord::RecordNotFound if item.nil?
		@items.delete_at(item)
	end
	
	def total_price
		@items.sum do |item| 
			item.price
		end
	end
end
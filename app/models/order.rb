class Order < ActiveRecord::Base
	has_one :address, :as => :addressable
	belongs_to :order_type
	belongs_to :order_state
	belongs_to :customer
	has_many :items, :class_name => "OrderItem"
	
	validates_presence_of :order_type
	
	def add_items_from_cart(cart)
		cart.items.each do |item|
			items << OrderItem.new do |order_item|
				order_item.product = item.product
				order_item.quantity = item.quantity
				order_item.total_price = item.price
			end
		end
		self.save
	end
end

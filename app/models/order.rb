class Order < ActiveRecord::Base
	has_one :address, :as => :addressable
	belongs_to :order_type
	belongs_to :order_state
	has_many :items, :class_name => "OrderItem"
end

class Customer < ActiveRecord::Base
	has_one :address, :as => :addressable
	belongs_to :user
	has_many :orders
end

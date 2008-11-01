class Category < ActiveRecord::Base
	has_many :products
	has_many :attrs, :class_name => "CategoryAttribute"
	acts_as_tree :order => "name"
#
# Validációk
# 
	validates_presence_of :name

	protected
	def validate
		#
		# Név: Kategórián belül egyedinek kell lennie
		siblings.each do |s|
			errors.add(:name, "a kategórián belül egyedinek kell lennie") if s.name == self.name
		end
	end
end

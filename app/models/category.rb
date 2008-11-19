class Category < ActiveRecord::Base
	has_many :products
	has_many :attrs, :class_name => "CategoryAttribute"
	acts_as_tree :order => "name"

	validates_presence_of :name
	validates_uniqueness_of :name, :scope => [:parent_id], :message => "a kategórián belül egyedinek kell lennie"
	
	named_scope :roots, :conditions => {:parent_id => 0}
	
	# Return all sub categories id under the tree
	# 
	# Visszaadja az összes alkategória id-jét a fában lefele
	# 
	# könyvek(id 1)
	#  \_ szépirodalom id(11)
	#			 \_20. század id(12)
	# 			 \_ A-K (id 121)
	# 			 \_ L-Z (id 122)
	#			 \_19. század id(14)
	# 
	# Például ha a fenti fában meghívod a szépirodalom nevű kategóriára
	# akkor a kimenet valami ilyesmi lesz	[12,121,122,14]
	# 
	# Ideális megkeresni egy adott kategória összes termékét
	# Product.find :all, :conditions => { :category_id => Category.releated_category_ids }
	# Mivel így egy SQL kéréssel megkapjuk az összeset, szemben ha rekurzívan bejárnánk a fa
	# összes elemét az n-nyi kérést jelente, ráadásul a named_scope-ok is használhatóak így.
	# 
	# A +Product.in_categories(Category.releated_category_ids ).sort_by(:name)
	def releated_category_ids()
		ids = [] << self.id
		self.children.each do |child_category|
			ids += child_category.releated_category_ids #rekurzív hívás
		end
		ids
	end
	
	def is_root?
		return self.parent.nil?
	end
	
	# Collect all ancestors attributes
	# 
	def ancestors_category_attributes()
		self.ancestors.collect { |category| category.attrs }.flatten
	end
	
	def category_attributes=(category_attributes)
		category_attributes.each do |attribute|
			attrs.build(attribute) unless attribute[:name].length.zero?
		end
	end
end

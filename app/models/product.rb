class Product < ActiveRecord::Base
	belongs_to :category
	has_many :attrs, 	:class_name => "ProductAttribute"
	has_many :category_attributes, :through => :attrs
	has_many :images, :class_name => "ProductImage"
	has_and_belongs_to_many :tags

	validates_presence_of :name, :price, :category_id
	validates_existence_of :category
	# Minimun ar >= 1 Ft es egesz szam
	# Minumun price must be >= 1 Ft and must be integer
	validates_numericality_of :price, :only_integer => true, :greater_than_or_equal_to => 1
		
	named_scope :popular, :conditions => {}
	named_scope :sale, :conditions => {}
	named_scope :limit, :limit => 3
	named_scope :in_category, lambda { |ids| 
		{ :conditions => { :category_id => ids } } 
	}
	
	named_scope :order_by, lambda{ |field| 
		{ :order => "#{field} ASC" }
	}
	
	named_scope :name_is_like, lambda { |name|
		{:conditions => ['name LIKE ?', "%#{name}%"] }
	}
	
	# A Termékhez kapcsolódó további termékek pl. hasonló kategóriájúak, címkéjűek stb.
	def releated(limit=10)
		products = Product.in_category(self.category).order_by(:price).limit(limit)
		products.delete(self)
		products
	end
	
	def image_file=(uploaded_data)
		return if uploaded_data == ''
		
		if self.new_record?
			images.build do |i|
				i.description = self.name
				i.data = uploaded_data # ProductImage will be handle the upload
			end
		else
			images.create do |i|
				i.description = self.name
				i.data = uploaded_data # ProductImage will be handle the upload
			end
		end
	end
	
	def self.search(name)
		self.name_is_like(name)
	end
	
	def new_tags_from_checkbox=(tags)
		tags.each do |tag_name|
			self.tags.build(:name => tag_name)
		end
	end
	
	def new_tags_from_string=(tags_string)
		return if tags_string == ""
		tags_string.split(", ").each do |tag_name|
			self.tags.build(:name => tag_name)
		end
	end
	
	def existing_attrs=(product_attributes)
		self.attrs.update product_attributes.keys, product_attributes.values
	end
	
	def new_attrs=(product_attributes)
		product_attributes.each do |attribute_hash|
			attrs.build(attribute_hash)
		end
	end
end

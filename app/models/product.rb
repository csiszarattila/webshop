class Product < ActiveRecord::Base
	belongs_to :category
	has_many :attrs, :class_name => "ProductAttribute"
	has_many :category_attributes, :through => :attrs
	has_and_belongs_to_many :tags
	has_many :images, :class_name => "ProductImage"

	validates_presence_of 		:name, :price, :category_id
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
		Product.in_category(self.category).order_by(:price).limit(limit)
	end
	
	def image_file=(uploaded_data)
		return unless uploaded_data
		file_extension = uploaded_data.original_filename.split(".").last
		file_upload_name = "product_#{self.id}_image_#{self.images.size.next}.#{file_extension}"
		
		images.create do |i|
			i.image_url = file_upload_name
			i.description = file_upload_name
			i.data = uploaded_data # ProductImage will handle upload
		end
	end
	
	def self.search(name)
		self.name_is_like(name)
	end
end

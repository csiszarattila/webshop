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
		return if uploaded_data == ''
		file_extension = uploaded_data.original_filename.split(".").last
		file_upload_name = "product_image_#{self.images.count.next}.#{file_extension}"
		
		if self.new_record?
			images.build do |i|
				i.image_url = file_upload_name
				i.description = ""
				i.data = uploaded_data # ProductImage will be handle the upload
			end
		else
			images.create do |i|
				i.image_url = file_upload_name
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
end

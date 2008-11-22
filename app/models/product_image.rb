class ProductImage < ActiveRecord::Base
	belongs_to :product
	
	validates_presence_of :description, :image_url
	
	# A termék képek elérése a gyökértől
	PRODUCT_IMAGES_PATH = '/images/products'
	# Alapértelmezett kép, ha nem tartozik egy sem a termékhez
	DEFAULT_PRODUCT_IMAGE_NAME = 'default.png'
	
	# Az +image_url+ -hez hozzáadjuk a +PRODUCT_IMAGES_PATH+ -ot
	def image_url
		PRODUCT_IMAGES_PATH + '/' + self[:image_url]
	end
	
	def after_destroy
		# remove image from disk
		FileUtils.rm_rf(File.join(RAILS_ROOT,'public',self.image_url))
	end
	
	# upload data
	def data=(uploaded_data)
		file_upload_path = File.join(RAILS_ROOT,'public',self.image_url) #assumed that image_url has setted!
		File.open(file_upload_path,'w') { |file| file.write(uploaded_data.read) }
	end
	
	def self.default
		self.new(:image_url => DEFAULT_PRODUCT_IMAGE_NAME, :description => "Default image")
	end
end

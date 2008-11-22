class ProductImage < ActiveRecord::Base
	belongs_to :product
	
	validates_presence_of :description, :image_url
	
	# A termék képek elérése a gyökértől
	PRODUCT_IMAGES_PATH = '/images/products'
	
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
end

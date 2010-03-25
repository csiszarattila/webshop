class ProductImage < ActiveRecord::Base
	belongs_to :product
	
	validates_presence_of :image_url
	
	# A termék képek elérése a gyökértől
	PRODUCT_IMAGES_PATH = '/images/products'
	# Alapértelmezett kép, ha nem tartozik egy sem a termékhez
	DEFAULT_PRODUCT_IMAGE_NAME = 'default.png'
	
  def image_name(size='normal')
    size ='normal' unless ["uploaded","normal","medium","small"].include?(size)
    image_name = self[:image_url].gsub(/(\{:size\})/, size)
  end

  def image_path(size)
	  File.join(RAILS_ROOT,'public', PRODUCT_IMAGES_PATH, image_name(size))
  end
  
	# Az +image_url+ -hez hozzáadjuk a +PRODUCT_IMAGES_PATH+ -ot
	def image_url(size='normal')
		PRODUCT_IMAGES_PATH + '/' + image_name(size)
	end
	
	def after_destroy
		# remove image from disk
		FileUtils.rm_rf(File.join(RAILS_ROOT,'public',self.image_url))
	end
	
	# upload data
	def data=(uploaded_data)
		file_extension = uploaded_data.original_filename.split(".").last
		self.image_url = "#{ProductImage.last.id+1}_{:size}.#{file_extension}"

		File.open(self.image_path('uploaded'),'w') { |file| file.write(uploaded_data.read) }
		image = MiniMagick::Image.from_file(self.image_path('uploaded'))
    image.resize "150x150"
    image.write(self.image_path('normal'))
    image.resize "75x75"
    image.write(self.image_path('medium'))
    image.resize "50x50"
    image.write(self.image_path('small'))
	end
	
	def self.default
		self.new(:image_url => DEFAULT_PRODUCT_IMAGE_NAME, :description => "Default image")
	end
end

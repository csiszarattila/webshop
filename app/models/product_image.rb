class ProductImage < ActiveRecord::Base
	belongs_to :product
	
	validates_presence_of :description, :image_url
	
	# A termék képek elérése a gyökértől
	PRODUCT_IMAGES_PATH = '/images/products'
	
	# Az +image_url+ -hez hozzáadjuk a +PRODUCT_IMAGES_PATH+ -ot
	def image_url
		PRODUCT_IMAGES_PATH + '/' + self[:image_url]
	end
end

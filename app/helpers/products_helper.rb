module ProductsHelper
	
	def sample_image_for_product(product,args=nil)
		if product.images.size.zero?
			image_for_product(product.images.default, args)
		else
			image_for_product(product.images.first, args)
		end
	end
	
	def image_for_product(image, args=nil)
		options = {:size => '150x150', :alt => ""}
		options[:alt] = image.description
		options.merge!(args) unless args.nil? # Given args overwrites default options
		image_tag( image.image_url, options )
	end
	
	def format_price(price)
		number_to_currency(	price, 
			:precision => 0,
			:unit => "Ft", 
			:delimiter => ",",
			:format => "%n<span class='currency'>%u</span>" )
	end
	
	def price_for_product(product)
		format_price(product.price)
	end
end

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
		link_to image_tag( image.image_url, options ), image.image_url, {:rel=>"lightbox"}
	end
	
	def format_price(price)
		number_to_currency(	price, 
			:precision => 0,
			:unit => "Ft", 
			:delimiter => ",",
			:format => "<span class='value'>%n</span><span class='currency'>%u</span>" )
	end
	
	def price_for_product(product)
		format_price(product.price)
	end
end

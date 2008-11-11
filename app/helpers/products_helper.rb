module ProductsHelper
	def image_for_product(product)
		image_tag( product.images.first.image_url, 
			:size => "150x150", 
			:alt => product.images.first.description )
	end
	
	def price_for_product(product)
		number_to_currency( 1245, 
			:unit => "Ft", 
			:delimiter => ",", 
			:format => "%n <span class='currency'>%u</span>" )
	end
end

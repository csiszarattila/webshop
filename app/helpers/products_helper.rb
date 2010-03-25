module ProductsHelper
  
	def product_main_image(product)
      if product.images.size.zero?
      product.images.default
    else
      product.images.first
    end
  end
  
  def product_image_tag(image, args=nil)
    options = {:size => 'normal', :alt => "", :class => "product-image", :alt => image.description }
    
    options.merge!(args) unless args.nil? # Given args overwrites default options
    image_tag( image.image_url(options.delete(:size)), options )
  end
  	
	def product_image_url(image, args=nil)
		options = {
		  :size => 'normal', :image_url_size => "uploaded", :class => "product-image", 
		  :alt => image.description, :lightbox => true, :title => image.description }
    options[:url] = image.image_url(options[:image_url_size])
    options.merge!(args) unless args.nil? # Given args overwrites default options
    
    url_options = { :title => image.description }
    url_options[:class] = "lightbox" if options[:lightbox]
    
    options.delete(:lightbox)
    
    link_to product_image_tag(image, options ), options[:url], url_options
	end
  
  def product_sample_image_url(product, args=nil)
    image = product_main_image(product)
    
    product_image_url(image, args);
  end
	
	def format_price(price)
		number_to_currency(	price, 
			:precision => 0,
			:unit => "Ft", 
			:delimiter => " ",
			:format => "<span class='value'>%n</span><span class='currency'>%u</span>" )
	end
	
	def price_for_product(product)
		format_price(product.price)
	end
end

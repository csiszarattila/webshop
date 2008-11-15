# A Class that generates custom wrappers around an input
#
# Calling this:
#
# form.text_field :title, :label => "Cím"
#
# Would produce this:
# 
# <div class="input">
# 	<label for="post_title">Cím</label>
# 	<br />
# 	<input id="post_title" label="Cím" name="post[title]" size="30" type="text" />
# </div>
#
# 
# Using: Just give MyFormBuilder class name to :builder parameter in form_for.
#
# Example: form_for ... :builder=>MyFormBuilder ... do |f|
# 
# See for original idea: 
# http://onrails.org/articles/2008/06/13/advanced-rails-studio-custom-form-builder
# 
# 

class MyFormBuilder < ActionView::Helpers::FormBuilder
	
	# The wrapper div's css class name
	INPUT_CLASS_NAME = "input"
	# The wrapper div's class name if there is an error occured on the form's field
	ERROR_CLASS_NAME = "field-with-error"

	# All helpers that be used
	# Actually this is all field helpers minus some other helpers, because dont want to wrap such as hidden fields, labels, field_for etc.
	helpers = field_helpers - %w(hidden_field label fields_for)
	
	helpers.each do |name|
		define_method(name) do |field,args|
			args.merge!( { :size => "20" }) unless args[:size]
			wrapper_div_classes = ""
			
			label = label(field,args.delete(:label))

			wrapper_div_classes << INPUT_CLASS_NAME
			wrapper_div_classes << " #{ERROR_CLASS_NAME}" unless @object.errors.on(field).nil?
				
			@template.content_tag(:div,label+"<br />"+super,:class=>wrapper_div_classes)
		end
	end
	
	def custom_error_messages(options = {})
		return if @object.errors.empty?
		options[:header_message] = "" unless options.include?(:header_message)
	  options[:message] ||= "" unless options.include?(:message)
	 
	  contents = "<div class='error-messages'>"
    contents << "<h4>#{options[:header_message]}</h4>" unless options[:header_message].blank?
    contents << "<p>#{options[:message]}</p>" unless options[:message].blank?
    contents << @object.errors.full_messages.map {|msg| "<p>#{msg}</p>" }.join
		contents << "</div>"
	end
	
	
	# Wrap around a radio button group in such a way:
	# 
	# <legend class="as-label">options[:legend]</legend>
	# <div class="radio-group">
	# 	...&block return value...
	# </div>
	# 
	# The wrapper div's content is the return value of the block
	# 
	# The block got the radio_group_options one by one, so you can
	# fetch elements and decide which attribute will be for example
	# the label tag or anyhing.
	#
	# And of course it checks the error messages and adds the appropriate css classes 
	# Use it at forms as:
	# = f.radio_group :order_type, @order_types, :legend => "Fizetési és szállítási mód" do |ot|
	# 	- radio_button("order", "order_type_id", ot.id) + f.label(:order_type, ot.name)
	# 
	# 
	# A blokként átadott radio gombokat körülveszi a megadott módon. 
	# Minden +radio_group_options+ -ra meghivja a kapott blokkot egyesével, 
	# a blokk paraméterként megkapja a radio_group_options elemeit,
	# a blokk visszatérési értékét pedig összeilleszti, és becsomagolja a megfelelő formátumba:
	# 
	# <legend class="as-label">options[:legend]</legend>
	# <div class="radio-group">
	# 	...&block visszatérési értéke...
	# </div>
	# 
	# Így a formban csak ennyit kell tenni:
	# 
	# = f.radio_group :order_type, @order_types, :legend => "Fizetési és szállítási mód" do |ot|
	# 	- radio_button("order", "order_type_id", ot.id) + f.label(:order_type, ot.name)
	# 
	def radio_group(method,radio_group_options,options = {}, &blk)
		legend_class = "" << "as-label"
		legend_class << "as-label-with-error" if @object.errors.invalid?(method)
		
    wrapper_div_classes = "" << "radio-group"
		wrapper_div_classes << " radio-group-with-error" if @object.errors.invalid?(method)
		
		radio_group_contents = ""
		for option in radio_group_options
			radio_group_contents << yield(option)
			radio_group_contents << "<br/>"
		end
		
		output = @template.content_tag(:legend, options[:legend], :class => legend_class)
		output << @template.content_tag(:div,radio_group_contents, :class => wrapper_div_classes)
	end
end

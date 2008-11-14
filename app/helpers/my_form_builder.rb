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
			
			label = label(field,args[:label])

			wrapper_div_classes << INPUT_CLASS_NAME
			wrapper_div_classes << " #{ERROR_CLASS_NAME}" unless @object.errors.on(field).nil?
				
			@template.content_tag(:div,label+"<br />"+super,:class=>wrapper_div_classes)
		end
	end
end

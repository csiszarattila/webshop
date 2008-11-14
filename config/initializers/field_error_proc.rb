#
# Overwrite the rails default <div class="fieldWithError"><input.../></div> method
# 
ActionView::Base.field_error_proc = Proc.new do |html_tag,instance_tag|
	html_tag
end


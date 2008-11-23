module TagsHelper
	# Comes from: http://www.juixe.com/techknow/index.php/2006/07/15/acts-as-taggable-tag-cloud/
	def tag_cloud tags, css_classes
		min, max = 0, 0
		tags.each do |tag|
			min = tag.count if tag.count < min
			max = tag.count if tag.count > max
		end
		
		divisor = ((max-min) / css_classes.size) + 1
		
		tags.each do |tag|
			yield tag, css_classes[(tag.count-min)/divisor]
		end
	end
end

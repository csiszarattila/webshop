module CategoriesHelper
	def nested_list_for_categories(categories)
		return "" if categories.empty?
		out = ""
		out += "<li class='current'>"
		category = categories.pop
		out += link_to(category.name, category_path(category))
		out += nested_list_for_categories(categories)
		out += "</li>"
	end
end

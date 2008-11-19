module Admin::CategoriesHelper
	def category_options_for_select(root_categories, selected_category)
		text = ""
		if selected_category.is_root?
			category = root_categories.delete(selected_category)
			text << "<option value='0' selected='selected'>Főkategória</option>"
		else
			text << "<option values='0'>Főkategória</option>"
		end
		root_categories.each do |root_category|
			text << category_options(root_category, selected_category, level=0)
		end
		text
	end
	
	def category_options(category, selected_category, level)
		text =	"<option value='#{category.id}'"
		text << " selected='selected'" if selected_category and selected_category.parent and category.id == selected_category.parent.id
		text << ">"
		text << "-"*level + category.name
		text << "</option>"
		level+=1 if category.children
		category.children.map do |child_category|
			text << category_options(child_category, selected_category, level)
		end
		text
  end

	def product_category_options_for_select(root_categories, selected_category=nil)
		text = ""
		root_categories.each do |root_category|
			text << category_options(root_category, selected_category, level=0)
		end
		text
	end
end
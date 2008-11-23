# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def back_link()
		request.env["HTTP_REFERER"]
	end
end

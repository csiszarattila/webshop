load_path = Dir[ File.join(RAILS_ROOT, 'app', 'locales', '*.{rb,yml}') ]

load_path.each do |file|
	Rails.logger.info("** [locales] Loaded locales file: #{file}")
end
I18n.load_path += load_path

I18n.default_locale = "hu-HU"

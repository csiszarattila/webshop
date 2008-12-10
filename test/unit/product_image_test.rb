require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "destroy is delete image from disk" do
		image = product_images(:rails_book_picture)
		file_path = File.join(RAILS_ROOT,'public',image.image_url)
		image.destroy
		assert !File.exist?(file_path), file_path
  end

	def teardown
		# Restore deleted image
		# Törölt kép visszaállítása
		image_url = product_images(:rails_book_picture).image_url_before_type_cast
		FileUtils.cp(
			File.join(RAILS_ROOT, 'test', 'fixtures', 'images', image_url), 
			File.join(RAILS_ROOT, 'public', product_images(:rails_book_picture).image_url)
		)
	end
end

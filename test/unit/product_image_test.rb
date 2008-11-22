require 'test_helper'

class ProductImageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "destroy delete image from disk" do
		image = product_images(:rails_book_picture)
		file_path = File.join(RAILS_ROOT,'public',image.image_url)
		image.destroy
		assert !File.exist?(file_path), file_path
  end
end

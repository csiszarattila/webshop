require 'test_helper'

class OrderTypeTest < ActiveSupport::TestCase
  test "empty order type is invalid" do
		order_type = OrderType.new()
		assert !order_type.valid?
		assert order_type.errors.invalid?(:name)
	end
	
  test "order type must be unique" do
		order_type = OrderType.new()
		order_type.name = order_types(:no_delivery_with_cash).name
		
		assert !order_type.valid?
		assert_equal I18n.translate('activerecord.errors.messages.taken'), order_type.errors.on(:name)
  end
end

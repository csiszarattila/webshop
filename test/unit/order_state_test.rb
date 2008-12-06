require 'test_helper'

class OrderStateTest < ActiveSupport::TestCase
  test "empty order state is invalid" do
		order_state = OrderState.new()
		assert !order_state.valid?
		assert order_state.errors.invalid?(:name)
	end
	
  test "order state must be unique" do
		order_state = OrderState.new()
		order_state.name = order_states(:new_order).name
		
		assert !order_state.valid?
		assert_equal I18n.translate('activerecord.errors.messages.taken'), order_state.errors.on(:name)
  end
end

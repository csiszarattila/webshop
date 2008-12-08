require 'test_helper'

class ApplicationMailerTest < ActionMailer::TestCase
  test "password_remember" do
    @expected.subject = 'ApplicationMailer#password_remember'
    @expected.body    = read_fixture('password_remember')
    @expected.date    = Time.now

		new_password = users(:attila).random_password
		@recepient = Customer.find_by_user_id(users(:attila).id)
   # assert_equal @expected.encoded, ApplicationMailer.create_password_remember(@recepient.address.email,@recepient.address .name,new_password).encoded
  end

end

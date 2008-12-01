require 'test_helper'

class ApplicationMailerTest < ActionMailer::TestCase
  test "password_remember" do
    @expected.subject = 'ApplicationMailer#password_remember'
    @expected.body    = read_fixture('password_remember')
    @expected.date    = Time.now

    assert_equal @expected.encoded, ApplicationMailer.create_password_remember(@expected.date).encoded
  end

end

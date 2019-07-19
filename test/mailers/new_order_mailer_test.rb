require 'test_helper'

class NewOrderMailerTest < ActionMailer::TestCase
  test "index" do
    mail = NewOrderMailer.index
    assert_equal "Index", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "contact_mail" do
    mail = NoticeMailer.contact_mail
    assert_equal "Contact mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

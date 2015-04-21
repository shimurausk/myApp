class NoticeMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.contact_mail.subject
  #
  def contact_mail
    @greeting = "お問い合わせ"
    # @contact = contact

    mail to: "to@example.org"

    mail subject: "myAppからお問い合わせがありました"
  end
end

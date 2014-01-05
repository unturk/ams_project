class ModelMailer < ActionMailer::Base
  default from: "mertersitesi@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_request.subject
  #
  def new_request(name_, subject_, content_)
    @subject = subject_
    @name = name_
    @content = content_

    #mail to: "ahmetaslan1956@gmail.com", subject: @subject
    mail to: "turgutfelek@gmail.com", subject: @subject
  end
end

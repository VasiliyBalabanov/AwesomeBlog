class UserMailer < ActionMailer::Base
  default from: "hellofrompiter@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
  
  def welcome(user)
    @user = user
    @greeting = "Hi"

    mail to: @user.email, subject: "Welcome!"
  end
end

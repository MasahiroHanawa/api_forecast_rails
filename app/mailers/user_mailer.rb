class UserMailer < ApplicationMailer
  default from: 'cosmic.wonder.jeans@gmail.com'

  def confirmation_email(user)
    @user = user
    @url = 'http://localhost:8081/signup/confirm?confirmation_token=' + @user.confirmation_token
    mail(
        to: @user.email,
        subject: 'Welcome to My Awesome Site',
        template_name: 'user_confirm'
    )
  end
end

class MessageMailer < ApplicationMailer

  # デフォルトでの送信元のアドレス
  default from: 'masahirohanawa0405@gmail.com'
  def hello()
    # @name = name
    mail(
        to:      'masahirohanawa0405@gmail.com',
        subject: 'Mail from Message',
    ) do |format|
      format.text
    end
  end
end

class UserMailer < ApplicationMailer

  default from: 'notifcation@example'

  def send_win_confirmation(item)
    @item = item
    mail(to: item.user.email, subject: 'You win the lottery')
  end
end

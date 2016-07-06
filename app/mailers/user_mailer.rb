class UserMailer < ApplicationMailer

  default from: 'notifcation@example'

  def send_win_confirmation(user, item)
    @user = user
    @item = item
    mail(to: @user.email, subject: 'You win the lottery')
  end
end

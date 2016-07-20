class DrawWinner < BusinessProcess::Base
  needs :item

  steps :can_run_draw,
        :do_raffle

  private

  def rand_winner
    winner = item.bids.order('RANDOM()').first
    item.user_id = winner.user_id
    item.save
  end

  def send_mail
    UserMailer.send_win_confirmation(item).deliver_now
  end

  def can_run_draw
    fail(:not_enough_bids) if item.bids.count < 2
  end

  def do_raffle
    rand_winner
    send_mail
  end
end

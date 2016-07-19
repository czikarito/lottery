class DrawWinner < Struct.new(:item)
  def rand_winner
    if can_run_draw?
      winner = item.bids.order('RANDOM()').first
      item.user_id = winner.user_id
      send_mail
    else
      'You cannot run draw'
    end
  end

  private

  def send_mail
    UserMailer.send_win_confirmation(item).deliver_now
  end

  def can_run_draw?
    item.bids.count >= 2 ? true : false
  end
end

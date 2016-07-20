class DrawWinner
  attr_accessor :item

  def initialize(item)
    @item = item
    @errors = []
  end

  def errors
    @errors
  end

  def call
    rand_winner if can_run_draw?
  end

  private

  def rand_winner
    winner = item.bids.order('RANDOM()').first
    item.user_id = winner.user_id
    send_mail
  end

  def send_mail
    UserMailer.send_win_confirmation(item).deliver_now
  end

  def can_run_draw?
    if item.bids.count >= 2
      true
    else
      @errors << 'You cannot run draw'
      false
    end
  end
end

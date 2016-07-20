# class DrawWinner
#   attr_accessor :item, :errors
#
#   def initialize(item)
#     @item = item
#     @errors = []
#   end
#
#   def call
#     if can_run_draw?
#       rand_winner
#       send_mail
#     end
#   end
#
#   private
#
#   def rand_winner
#     winner = item.bids.order('RANDOM()').first
#     item.user_id = winner.user_id
#   end
#
#   def send_mail
#     UserMailer.send_win_confirmation(item).deliver_now
#   end
#
#   def can_run_draw?
#     if item.bids.count >= 2
#       true
#     else
#       @errors << 'You cannot run draw'
#       false
#     end
#   end
# end
class DrawWinner < BusinessProcess::Base
  attr_accessor :item

  #needs :item

  steps :can_run_draw,
        :do_raffle

  # def errors
  #   @errors
  # end

  def initialize(item)
    @item = item
  end

  private

  def rand_winner
    winner = item.bids.order('RANDOM()').first
    item.user_id = winner.user_id
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

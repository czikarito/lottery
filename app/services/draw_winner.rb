class DrawWinner < Struct.new(:item)

  def can_run_draw?
    item.bids.count >=2 ? true : false
  end

end

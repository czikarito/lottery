class AuctionsController < ApplicationController

  def index
    @items = Item.all
  end

end
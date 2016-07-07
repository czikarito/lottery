class BidsController < ApplicationController

  def create
    @item = Item.find(bid_params[:item_id])
    @bid = @item.bids.build(user: current_user)
    respond_to do |format|
      if @bid.save
        format.html { redirect_to @item, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to @item, notice: 'You already bid this item.' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:item_id)
  end
end

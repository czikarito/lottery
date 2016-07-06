class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :destroy]

  def index
    @bids = Bid.all
  end

  def create
   @item = Item.find(bid_params[:item_id])
   @bid = @item.bids.build(user: current_user)
    binding.pry
    respond_to do |format|

      if @bid.save
        format.html { redirect_to @item, notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to @item ,notice: 'You already bid this item.' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:item_id)
    end
end

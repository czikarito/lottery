class ItemsController < ApplicationController
  respond_to :html, :json

  expose :q, -> { Item.ransack(search_params) }
  expose :items, -> { q.result(distinct: true).where(user_id: nil).page params[:page] }
  expose :item

  def index
  end

  def draw
      winner = item.lottery(item)
      item.user_id = winner
      item.save
      UserMailer.send_win_confirmation(item).deliver_now
  end

  def create
    item.save
    respond_with(item)
  end

  def update
      if item.update(item_params)
        redirect_to item_path(item), notice: 'Item was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    item.destroy
    respond_with(item)
  end

  private

  def search_params
    params.permit(q: [ :name_cont ])["q"].to_h
  end

  def item_params
      params.require(:item).permit(:name, :description, :image)
    end
end

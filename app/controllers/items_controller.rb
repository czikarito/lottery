class ItemsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_admin, only: [:destroy, :create, :update, :draw]
  before_action :count_bids, only: [:destroy]

  expose :q, -> { Item.ransack(search_params) }
  expose :items, -> { q.result(distinct: true).where(user_id: nil).page params[:page] }
  expose_decorated(:item, decorator: ItemDecorator)

  def index
  end

  def draw
    DrawWinner.call(item: item)
  end

  def create
    item.save
    respond_with(item)
  end

  def update
    if item.update(item_params)
      redirect_to item_path(item), notice: 'Item was successfully updated.'
    end
  end

  def destroy
    item.destroy
    respond_with(item)
  end

  private

  def authenticate_admin
    unless current_user && current_user.has_role?(:admin)
      redirect_to new_user_session_path
    end
  end

  def count_bids
    redirect_to item_path item unless item.bids.count == 0
  end

  def search_params
    params.permit(q: [:name_cont])['q'].to_h
  end

  def item_params
    params.require(:item).permit(:name, :description, :image)
  end
end

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
    if current_user && current_user.has_role?(:admin)
      item.save
      respond_with(item)
    elsif current_user
      redirect_to items_path, notice: 'You cannot create item!'
    else
      redirect_to new_user_session_path
    end
  end

  def update
    if current_user && current_user.has_role?(:admin)
      if item.update(item_params)
        redirect_to item_path(item), notice: 'Item was successfully updated.'
      end
    elsif current_user
      redirect_to items_path, notice: 'You cannot update item!'
    else
      redirect_to new_user_session_path
      end
  end

  def destroy
    if current_user && current_user.has_role?(:admin)
      item.destroy
      respond_with(item)
    elsif current_user
      redirect_to item_path(item), notice: 'You cannot delete item!'
    else
      redirect_to new_user_session_path
    end
end

  private

  def search_params
    params.permit(q: [:name_cont])['q'].to_h
  end

  def item_params
    params.require(:item).permit(:name, :description, :image)
    end
end

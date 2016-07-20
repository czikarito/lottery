class ItemDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def edit_link
    link_to 'Edit', edit_item_path(item) if is_admin?
  end

  def delete_link
    if is_admin?
      link_to 'Destroy', item, method: :delete, data: { confirm: 'Are you sure?' }
    end
  end

  def run_draw_or_bid
    if is_admin?
      link_to 'Run draw', draw_item_path(item), method: :post if can_run_draw?
    else
      link_to 'Bid It', bids_path(bid: { item_id: item.id }), method: :post if current_user
    end
  end

  private

  def is_admin?
    current_user && current_user.has_role?(:admin)
  end

  def can_run_draw?
    item.bids.size >= 2 && item.user_id.nil?
  end
end

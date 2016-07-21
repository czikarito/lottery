class ItemDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  include Draper::LazyHelpers

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def edit_link
    link_to 'Edit', edit_item_path(item) if is_admin?
  end

  def delete_link
    if is_admin?
      link_to 'Destroy', item, method: :delete, data: { confirm: 'Are you sure?' }
    end
  end

  def run_draw_or_bid
    if can_run_draw?
      link_to 'Run draw', draw_item_path(item), method: :post
    elsif current_user
      link_to 'Bid It', bids_path(bid: { item_id: item.id }), method: :post
    end
  end

  private

  def is_admin?
    current_user && current_user.has_role?(:admin)
  end

  def can_run_draw?
    item.bids.size >= 2 && item.user_id.nil? if is_admin?
  end
end

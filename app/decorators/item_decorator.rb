class ItemDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def edit_link
    if is_admin?
      link_to 'Edit', edit_item_path(item)
    end
  end

  def delete_link
  end

private

def is_admin?
  current_user and current_user.has_role? :admin
end
end

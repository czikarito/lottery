module ItemsHelper

  def is_admin?
    if current_user and current_user.has_role? :admin
      return true
    else
      return false
    end
  end
end

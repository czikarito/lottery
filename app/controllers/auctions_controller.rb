class AuctionsController < ApplicationController
  expose :items, -> { Item.all }
  expose :won_items, -> { items.where(user_id: current_user) }
  expose :binding_items, -> { items.where(user_id: nil && !current_user) }
  expose :lost_items, -> { items.where.not(user_id: current_user) }

  def index
  end

end
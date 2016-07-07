class Item < ApplicationRecord
  has_attached_file :image, styles: { medium: '400x600#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  resourcify

  paginates_per 6
  belongs_to :user
  has_many :bids

  def lottery(item)
    if item.bids.size >= 2
      win = item.bids.order('RANDOM()').first
      user = win.user_id
      return user
    end
  end
end

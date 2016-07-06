class Item < ApplicationRecord
  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  resourcify

  paginates_per 6
  has_many :bids
  accepts_nested_attributes_for :bids , :reject_if => :all_blank, :allow_destroy => true

  def lottery(item)
    if item.bids.size >=2
      win = item.bids.order("RANDOM()").first
      user = win.user
      return user
    end
  end


end

class Item < ApplicationRecord
  has_attached_file :image, styles: { medium: '400x600#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  resourcify

  paginates_per 6
  belongs_to :user
  has_many :bids
end

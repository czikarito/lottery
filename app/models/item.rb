class Item < ApplicationRecord
  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  resourcify

  paginates_per 6
  has_many :bids
  accepts_nested_attributes_for :bids , :reject_if => :all_blank, :allow_destroy => true

end

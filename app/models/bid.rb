class Bid < ApplicationRecord

  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :bidding

end

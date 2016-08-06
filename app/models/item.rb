class Item < ApplicationRecord
  has_attached_file :image, styles: { medium: '300x300#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  extend FriendlyId
  friendly_id :name, use: :slugged

  resourcify

  paginates_per 6
  belongs_to :user
  has_many :bids
end

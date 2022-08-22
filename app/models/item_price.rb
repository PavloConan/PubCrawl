class ItemPrice < ApplicationRecord
  belongs_to :item
  belongs_to :vendor

  validates_uniqueness_of :item_id, scope: :vendor_id

  def absolute_url
    return unless url

    vendor.url + url
  end
end
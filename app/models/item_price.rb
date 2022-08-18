class ItemPrice < ApplicationRecord
  belongs_to :item
  belongs_to :vendor
end
class Vendor < ApplicationRecord
  validates_presence_of :name, :url
  validates_uniqueness_of :name, :url
  has_many :item_prices, dependent: :destroy
end
class Vendor < ApplicationRecord
  validates_presence_of :name, :url
  validates_uniqueness_of :name, :url
  has_many :item_prices, dependent: :destroy
  has_many :potential_items, dependent: :destroy

  def self.forfiter
    find_by(sys_name: "forfiter")
  end
end
class Vendor < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates_presence_of :name, :url
  validates_uniqueness_of :name, :url
  has_many :item_prices, dependent: :destroy
  has_many :potential_items, dependent: :destroy

  def self.forfiter
    find_by(sys_name: "forfiter")
  end

  def self.dom_whisky
    find_by(sys_name: "dom_whisky")
  end
end
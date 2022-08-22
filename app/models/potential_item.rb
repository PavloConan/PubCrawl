class PotentialItem < ApplicationRecord
  validates_presence_of :name, :url
  validates :name, uniqueness: { scope: :vendor }
  belongs_to :vendor

  enum category: Item.categories
end
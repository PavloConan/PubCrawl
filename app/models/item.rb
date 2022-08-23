class Item < ApplicationRecord
  validates_presence_of :name
  has_many :item_prices, dependent: :destroy

  enum category: {
    "Bourbon" => 0,
    "Rum" => 1,
    "Gin" => 2,
    "Brandy" => 3,
    "Cognac" => 4,
    "Vermouth" => 5,
    "Tequila" => 6,
    "Mezcal" => 7,
    "Liqueur" => 8,
    "Whisky" => 9
  }
end
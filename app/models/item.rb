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
    "Whisky" => 9,
    "Absinthe" => 10,
    "Sake" => 11,
    "Armagnac" => 12,
    "Wine" => 13
  }

  def availability
    amount = item_prices.found.size

    if amount == 1
      "Znaleźliśmy w 1 sklepie"
    else
      "Znaleźliśmy w #{amount} sklepach"
    end
  end

  def lowest_price
    item_prices.found.minimum(:price)
  end
end
module ItemPrices
  class FillAll

    def self.call
      item_prices = ItemPrice.where.not(url: [nil, ""]).where(price: [nil, ""]).each do |item_price|
        PriceUpdater.call(item_price)
      end
    end
  end
end
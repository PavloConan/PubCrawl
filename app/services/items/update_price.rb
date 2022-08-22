module Items
  class UpdatePrice

    def initialize(item)
      @item = item
    end

    def call
      @item.item_prices.each do |item_price|
        next if item_price.url.blank?

        PriceUpdater.call(item_price)
      end
    end
  end
end
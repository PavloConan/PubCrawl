module ItemPrices
  class UpdatePrice

    def initialize(item_price)
      @item_price = item_price
    end

    def call
      new_price = PriceFinder.new(product_url, @item_price.vendor.price_xpath)
    end

    private

    def product_url
      @item_price.vendor.url + @item_price.url
    end
  end
end
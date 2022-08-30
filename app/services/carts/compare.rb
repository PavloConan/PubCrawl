module Carts
  class Compare

    def initialize(cart_items)
      @cart_items = cart_items
      @vendors = []
    end

    def call
      build_vendors

      @vendors.each do |vendor|
        @cart_items.each do |cart_item|
          item_price = vendor[:vendor].item_prices.found.find_by(item_id: cart_item[0])

          if item_price
            price = item_price.price * cart_item[2]
            vendor[:found].push({
              item: cart_item[1],
              amount: cart_item[2],
              price: price
            })

            vendor[:final_amount] += price
          else
            vendor[:not_found].push(cart_item[1])
          end
        end
      end

      @vendors.sort { |vendor| vendor[:found].size }.reverse
    end

    private

    def build_vendors
      Vendor.all.each do |vendor|
        @vendors.push({
          vendor: vendor,
          image_url: vendor.image_url,
          found: [],
          not_found: [],
          final_amount: 0.0
        })
      end
    end
  end
end
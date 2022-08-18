module Vendors
  class CreateItemPrices

    def initialize(vendor)
      @vendor = vendor
    end

    def call
      vendor_item_ids = @vendor.item_prices.pluck(:item_id)
      item_ids = Item.all.pluck(:id)

      items_to_create = (item_ids - vendor_item_ids).map { |item_id| { item_id: item_id } }

      @vendor.item_prices.insert_all(items_to_create)
    end
  end
end
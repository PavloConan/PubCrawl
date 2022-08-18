module Items
  class BulkCreate < BaseService
    def initialize(new_items, category)
      @new_items = new_items
      @category = category
      @base_vendor = Vendor.find_by(sys_name: "dom_whisky")
    end

    def call
      @new_items.each do |new_item|
        puts "Processing item #{new_item[:name]}..."

        item = Item.find_by(name: new_item[:name])

        if item
          puts "Item found!"
        else
          item = Item.create!(name: new_item[:name], category: @category)
          puts "Item created!"
        end

        base_vendor_price = item.item_prices.find_by(vendor_id: @base_vendor.id)

        if base_vendor_price.blank?
          item.item_prices.create!(
            vendor: @base_vendor,
            price: new_item[:price],
            url: new_item[:url]
          )

          puts "Item price for base vendor created!"
        else
          base_vendor_price.update!(
            price: new_item[:price]
          )
          puts "Item price for base vendor updated!"
        end

        Vendor.where.not(id: @base_vendor.id).each do |vendor|
          next if item.item_prices.find_by(id: vendor.id).present?
          item.item_prices.create!(
            vendor: vendor
          )
          puts "Created item price for vendor: #{vendor.name}"
        end
      end
    end
  end
end
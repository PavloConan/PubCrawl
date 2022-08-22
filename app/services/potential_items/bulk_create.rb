module PotentialItems
  class BulkCreate
    def initialize(items, vendor)
      @items = items
      @vendor = vendor
    end

    def call
      @items.each do |item|
        @vendor.potential_items.create(item)
      end
    end
  end
end
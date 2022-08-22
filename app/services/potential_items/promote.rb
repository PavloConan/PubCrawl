module PotentialItems
  class Promote

    WORDS_NOT_TITLEIZED = %w[
      XO VSOP VS
    ]

    def initialize(potential_item)
      @potential_item = potential_item
    end

    def call
      ActiveRecord::Base.transaction do
        item = Item.create!(
          name: beautify_name(@potential_item.name),
          category: @potential_item.category
        )

        @potential_item.vendor.item_prices.create!(
          item: item,
          url: @potential_item.url
        )

        Vendor.where.not(id: @potential_item.vendor.id).each do |vendor|
          vendor.item_prices.create!(
            item: item
          )
        end

        @potential_item.destroy!
      end
    end

    private

    def beautify_name(name)
      name.split(' ')
          .map { |x| WORDS_NOT_TITLEIZED.include?(x) ? x : x.capitalize  }
          .join(' ')
    end
  end
end
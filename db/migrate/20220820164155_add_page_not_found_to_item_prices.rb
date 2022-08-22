class AddPageNotFoundToItemPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :item_prices, :page_not_found, :boolean, default: true
  end
end

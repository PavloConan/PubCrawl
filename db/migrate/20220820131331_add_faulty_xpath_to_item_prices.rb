class AddFaultyXpathToItemPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :item_prices, :faulty_xpath, :boolean, default: false
  end
end

class ChangeDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :item_prices, :page_not_found, false
  end
end

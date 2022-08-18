class CreateItemPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :item_prices do |t|
      t.references :vendor, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.float :price, index: true
      t.string :url

      t.timestamps
    end
  end
end

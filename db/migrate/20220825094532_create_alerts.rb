class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :description
      t.string :item_price_url
      t.integer :item_price_id

      t.timestamps
    end
  end
end

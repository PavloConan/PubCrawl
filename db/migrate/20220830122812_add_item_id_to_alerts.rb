class AddItemIdToAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :item_id, :integer
  end
end

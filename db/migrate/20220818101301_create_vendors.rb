class CreateVendors < ActiveRecord::Migration[7.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :sys_name
      t.string :url
      t.float :shipment_cost

      t.timestamps
    end
  end
end

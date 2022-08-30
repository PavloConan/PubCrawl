class AddImageDataToVendors < ActiveRecord::Migration[7.0]
  def change
    add_column :vendors, :image_data, :jsonb
  end
end

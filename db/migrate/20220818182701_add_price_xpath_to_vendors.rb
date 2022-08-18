class AddPriceXpathToVendors < ActiveRecord::Migration[7.0]
  def change
    add_column :vendors, :price_xpath, :string
  end
end

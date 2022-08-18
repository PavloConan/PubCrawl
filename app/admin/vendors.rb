ActiveAdmin.register Vendor do
  config.sort_order = 'created_at ASC'

  filter :name
  filter :shipment_cost

  show do |vendor|
    attributes_table do
      row :id
      row :name
      row :shipping_cost
      row :url
      table_for vendor.item_prices do
        column :name do |item_price|
          link_to item_price.item.name, edit_admin_item_price_path(item_price.id)
        end
        column :price
        column :url
      end
    end
  end
end

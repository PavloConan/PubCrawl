ActiveAdmin.register Vendor do
  permit_params :name, :price_xpath, :shipment_cost
  config.sort_order = 'created_at ASC'

  filter :name
  filter :shipment_cost

  show do |vendor|
    attributes_table do
      row :id
      row :name
      row :shipping_cost
      row :url
      row :price_xpath
    end
  end

  form do |f|
    inputs do
      f.input :name
      f.input :shipment_cost
      f.input :price_xpath
    end
    f.submit
  end
end

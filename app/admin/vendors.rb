ActiveAdmin.register Vendor do
  permit_params :name, :price_xpath, :shipment_cost, :image
  config.sort_order = 'created_at ASC'

  filter :name
  filter :shipment_cost

  index do
    id_column
    column :name
    column :url
    column :shipping_cost
    actions
  end

  show do |vendor|
    attributes_table do
      row :id
      row :name
      row :shipping_cost
      row :url
      row :price_xpath
      row :image do
        image_tag(vendor.image_url) if vendor.image_data
      end
    end
  end

  form do |f|
    inputs do
      f.input :name
      f.input :shipment_cost
      f.input :price_xpath
      f.input :image, as: :file
    end
    f.submit
  end
end

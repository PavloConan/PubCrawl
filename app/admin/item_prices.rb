ActiveAdmin.register ItemPrice do
  permit_params :url, :price

  filter :vendor
  filter :item
  filter :price

  index do
    column :name do |item_price|
      item_price.item.name
    end
    column :url
    column :price do |item_price|
      number_to_currency(item_price.price, unit: "PLN", separator: ",", delimiter: "", format: "%n %u")
    end
    actions
  end

  form do |f|
    inputs do
      f.input :url
      f.input :price
    end
    f.submit
  end
end

ActiveAdmin.register ItemPrice do
  filter :vendor
  filter :item
  filter :price

  index do
    column :name do |item_price|
      item_price.item.name
    end
    column :price do |item_price|
      number_to_currency(item_price.price, unit: "PLN", separator: ",", delimiter: "", format: "%n %u")
    end
  end
end

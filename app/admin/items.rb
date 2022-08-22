ActiveAdmin.register Item do
  permit_params :name, :category
  config.sort_order = 'created_at ASC'
  filter :name
  filter :category, as: :select, collection: Item.categories
end

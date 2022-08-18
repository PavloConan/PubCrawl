ActiveAdmin.register Item do
  config.sort_order = 'created_at ASC'
  filter :name
  filter :category, as: :select, collection: Item.categories
end

ActiveAdmin.register Item do
  permit_params :name, :category
  config.sort_order = 'created_at ASC'
  filter :name
  filter :category, as: :select, collection: Item.categories

  Item.categories.keys.each do |category|
    batch_action :"mark_as_#{category.downcase}" do |ids|
      batch_action_collection.find(ids).each do |item|
        item.update!(category: category)
      end
      redirect_to request.referer, alert: "Items updated!"
    end
  end
end

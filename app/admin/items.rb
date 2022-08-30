ActiveAdmin.register Item do
  permit_params :name, :category, :image_url
  config.sort_order = 'created_at ASC'
  filter :name
  filter :category, as: :select, collection: Item.categories
  filter :image_url_present, as: :boolean

  Item.categories.keys.each do |category|
    batch_action :"mark_as_#{category.downcase}" do |ids|
      batch_action_collection.find(ids).each do |item|
        item.update!(category: category)
      end
      redirect_to request.referer, alert: "Items updated!"
    end
  end

  index do |item|
    selectable_column
    id_column
    column :name
    column :category
    actions
  end

  form do |f|
    inputs do
      f.input :name
      f.input :category
      f.input :image, as: :file
    end
    f.submit
  end

  show do |item|
    attributes_table do
      row :name
      row :category
      row :image do
        image_tag(item.image_url) if item.image_url
      end
      row :created_at
      row :updated_at
    end
  end

  controller do
    def create
      super
      Vendor.all.each do |vendor|
        vendor.item_prices.create!(
          item: @item
        )
      end
    end
  end

  batch_action :fetch_image_url do |ids|
    batch_action_collection.find(ids).each do |item|
      ImageFetcher.call(item)
    end
    redirect_to request.referer, alert: "Images fetched"
  end
end

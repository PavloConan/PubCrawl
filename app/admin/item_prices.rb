ActiveAdmin.register ItemPrice do
  permit_params :url, :price, :faulty_xpath, :page_not_found, :manual_update

  filter :vendor
  filter :"item_name", as: :string
  filter :"item_category", as: :select, collection: Item.categories
  # filter :price
  # filter :url
  filter :manual_update
  filter :price_present, as: :boolean
  filter :url_present, as: :boolean
  filter :faulty_xpath
  filter :page_not_found

  index row_class: ->elem { 'warning' if elem.faulty_xpath || elem.page_not_found || elem.price == 0.0 } do
    selectable_column
    id_column
    column :item, sortable: 'items.name' do |item_price|
      link_to item_price.item.name, admin_item_path(item_price.item)
    end
    column :vendor do |item_price|
      item_price.vendor.name
    end
    column :url do |item_price|
      if item_price.url
        link_to item_price.url, item_price.vendor.url + item_price.url
      else
        item_price.url
      end
    end
    column :price do |item_price|
      item_price.present? ? number_to_currency(item_price.price, unit: "PLN", separator: ",", delimiter: " ", format: "%n %u") : nil
    end
    column :manual_update
    actions
  end

  form do |f|
    inputs do
      f.input :url
      f.input :price
    end
    f.submit
  end

  batch_action :fetch_prices do |ids|
    batch_action_collection.find(ids).each do |item_price|
      PriceUpdater.call(item_price)
    end
    redirect_to request.referer, alert: "Item prices updated!"
  end

  batch_action :set_to_manual_update do |ids|
    batch_action_collection.find(ids).each do |item_price|
      item_price.update!(manual_update: true)
    end
    redirect_to request.referer, alert: "Item prices set to manual update!"
  end

  controller do
    def update
      super
      PriceUpdater.call(@item_price) if @item_price.price.blank?
    end

    def scoped_collection
      end_of_association_chain.includes(:item)
    end
  end
end

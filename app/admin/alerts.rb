ActiveAdmin.register Alert do
  actions :all, except: [:show, :new, :create, :edit, :update]

  index do
    column :description
    column :item_price_url do |alert|
      link_to alert.item_price_url, alert.item_price_url if alert.item_price_url
    end
    column :item_price_id do |alert|
      link_to alert.item_price_id, admin_item_price_path(alert.item_price_id) if alert.item_price_id
    end
    column :item_id do |alert|
      link_to alert.item_id, admin_item_path(alert.item_id) if alert.item_id
    end

    column :item
    column :created_at
    actions
  end
end

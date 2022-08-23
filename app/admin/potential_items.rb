ActiveAdmin.register PotentialItem do
  permit_params :name, :category, :url, :marked_for_promotion
  config.sort_order = 'created_at ASC'
  config.batch_actions = true
  filter :name
  filter :vendor
  filter :marked_for_promotion
  filter :category
  filter :category_present, as: :boolean

  index row_class: ->elem { 'promotion' if elem.marked_for_promotion } do
    selectable_column
    id_column
    column :name
    column :category
    column :url do |potential_item|
      if potential_item.url
        link_to potential_item.url, potential_item.vendor.url + potential_item.url
      else
        potential_item.url
      end
    end
    actions
  end

  batch_action :mark_for_promotion do |ids|
    batch_action_collection.find(ids).each do |potential_item|
      potential_item.update!(marked_for_promotion: true)
    end
    redirect_to request.referer, alert: "Potential items marked for promotion"
  end

  PotentialItem.categories.keys.each do |category|
    batch_action :"mark_as_#{category.downcase}" do |ids|
      batch_action_collection.find(ids).each do |potential_item|
        potential_item.update!(category: category)
      end
      redirect_to request.referer, alert: "Potential items updated!"
    end
  end

  batch_action :promote do |ids|
    batch_action_collection.find(ids).each do |potential_item|
      PotentialItems::Promote.new(potential_item).call
    end
    redirect_to request.referer, alert: "Items promoted!"
  end

  controller do
    def destroy
      super do |success,failure|
        success.html { redirect_to request.referer }
      end
    end
  end
end

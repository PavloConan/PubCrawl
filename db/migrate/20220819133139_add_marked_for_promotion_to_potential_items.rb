class AddMarkedForPromotionToPotentialItems < ActiveRecord::Migration[7.0]
  def change
    add_column :potential_items, :marked_for_promotion, :boolean, default: false
  end
end

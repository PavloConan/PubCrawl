class AddCategoryToPotentialItems < ActiveRecord::Migration[7.0]
  def change
    add_column :potential_items, :category, :integer, index: true
  end
end

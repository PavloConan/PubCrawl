class AddImageDataToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :image_data, :jsonb
  end
end

class DropImageDataFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :image_data
  end
end

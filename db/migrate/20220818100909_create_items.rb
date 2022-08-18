class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, index: { unique: true }
      t.integer :category, index: true
      t.timestamps
    end
  end
end

class CreatePotentialItems < ActiveRecord::Migration[7.0]
  def change
    create_table :potential_items do |t|
      t.references :vendor, null: false, foreign_key: true, index: true
      t.string :name, index: true
      t.string :url

      t.timestamps
    end
  end
end

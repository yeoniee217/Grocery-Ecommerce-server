class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :num
      t.string :name
      t.text :description
      t.integer :price
      t.integer :stock_quantity
      t.decimal :discount
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end

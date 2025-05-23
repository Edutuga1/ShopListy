class CreateProductsLists < ActiveRecord::Migration[7.1]
  def change
    create_table :products_lists do |t|
      t.references :product, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end

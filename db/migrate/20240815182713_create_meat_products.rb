class CreateMeatProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :meat_products do |t|
      t.string :name
      t.decimal :price
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end

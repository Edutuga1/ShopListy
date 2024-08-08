class CreateGroceries < ActiveRecord::Migration[7.1]
  def change
    create_table :groceries do |t|
      t.string :name
      t.decimal :price
      t.boolean :bought
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

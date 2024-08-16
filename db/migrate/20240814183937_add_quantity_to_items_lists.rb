class AddQuantityToItemsLists < ActiveRecord::Migration[7.1]
  def change
    add_column :items_lists, :quantity, :integer, default: 1
  end
end

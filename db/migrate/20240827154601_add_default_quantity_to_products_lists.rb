class AddDefaultQuantityToProductsLists < ActiveRecord::Migration[7.1]
  def change
    change_column_default :products_lists, :quantity, 0
  end
end

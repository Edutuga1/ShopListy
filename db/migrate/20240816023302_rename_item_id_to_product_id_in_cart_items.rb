class RenameItemIdToProductIdInCartItems < ActiveRecord::Migration[7.1]
  def change
    # Rename the column
    rename_column :cart_items, :item_id, :product_id

    # Remove the old index if it exists
    if index_exists?(:cart_items, :item_id, name: "index_cart_items_on_item_id")
      remove_index :cart_items, name: "index_cart_items_on_item_id"
    end

    # Add the new index only if it does not already exist
    unless index_exists?(:cart_items, :product_id, name: "index_cart_items_on_product_id")
      add_index :cart_items, :product_id, name: "index_cart_items_on_product_id"
    end

    # Update the foreign key
    remove_foreign_key :cart_items, column: :product_id if foreign_key_exists?(:cart_items, column: :product_id)
    add_foreign_key :cart_items, :products, column: :product_id
  end
end

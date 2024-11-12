class RenameItemIdToProductIdInCartItems < ActiveRecord::Migration[7.1]
  def change
    # First, ensure that the item_id column exists before renaming it
    if column_exists?(:cart_items, :item_id)
      rename_column :cart_items, :item_id, :product_id
    end

    # Remove the old index if it exists
    if index_exists?(:cart_items, :item_id, name: "index_cart_items_on_item_id")
      remove_index :cart_items, name: "index_cart_items_on_item_id"
    end

    # Add the new index only if it does not already exist
    unless index_exists?(:cart_items, :product_id, name: "index_cart_items_on_product_id")
      add_index :cart_items, :product_id, name: "index_cart_items_on_product_id"
    end

    # Remove the old foreign key and add the new one (if applicable)
    if foreign_key_exists?(:cart_items, column: :item_id)
      remove_foreign_key :cart_items, column: :item_id
    end

    # Add foreign key referencing the products table, only if it doesn't exist
    unless foreign_key_exists?(:cart_items, column: :product_id)
      add_foreign_key :cart_items, :products, column: :product_id
    end
  end
end

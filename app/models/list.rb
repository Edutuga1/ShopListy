class List < ApplicationRecord
  belongs_to :user
  has_many :products_lists, dependent: :destroy
  has_many :products, through: :products_lists

  accepts_nested_attributes_for :products_lists, allow_destroy: true

  # Add product to the list (assuming product_ids is serialized)
  def add_product(product, quantity = 1)
    product_list_item = products_lists.find_or_initialize_by(product: product)

    # Set the quantity if the item is new or increment if it exists
    product_list_item.quantity = (product_list_item.quantity || 0) + quantity

    if product_list_item.save
      Rails.logger.info("Product added to list with quantity: #{product_list_item.quantity}")
    else
      Rails.logger.error("Error saving product to list: #{product_list_item.errors.full_messages.join(", ")}")
    end
  end

  def total_cost
    products_lists.joins(:product).sum('products_lists.quantity * products.price')
  end

  # To get products associated with the list
  def products
    Product.where(id: product_ids)
  end
end

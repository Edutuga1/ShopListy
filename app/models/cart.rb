class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def add_product(product, quantity = 1)
    cart_item = cart_items.find_or_initialize_by(product: product)
    if cart_item.new_record?
      # Set the quantity to the specified value if it's a new item
      cart_item.quantity = quantity
    else
      # Increment the quantity if it’s an existing item
      cart_item.quantity += quantity
    end

    if cart_item.save
      Rails.logger.info("Cart item saved with quantity: #{cart_item.quantity}")
    else
      Rails.logger.error("Failed to save cart item: #{cart_item.errors.full_messages.join(", ")}")
    end
  end

  def remove_item(cart_item)
    cart_item.destroy
  end

  def update_item_quantity(cart_item, quantity)
    cart_item.update(quantity: quantity)
  end
end

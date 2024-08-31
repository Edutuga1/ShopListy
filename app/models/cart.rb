class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def add_product(product, quantity = 1)
    cart_item = cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + quantity
    cart_item.save
  end

  def remove_item(cart_item)
    cart_item.destroy
  end

  def update_item_quantity(cart_item, quantity)
    cart_item.update(quantity: quantity)
  end
end

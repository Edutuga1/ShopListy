class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def add_item(product, quantity)
    cart_item = cart_items.find_by(product: product)
    if cart_item
      cart_item.increment(:quantity, quantity)
      cart_item.save
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end

  def remove_item(cart_item)
    cart_item.destroy
  end

  def update_item_quantity(cart_item, quantity)
    cart_item.update(quantity: quantity)
  end
end

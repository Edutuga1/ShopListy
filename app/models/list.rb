class List < ApplicationRecord
  belongs_to :user
  has_many :products_lists
  has_many :products, through: :products_lists

  accepts_nested_attributes_for :products_lists, allow_destroy: true

  # Add product to the list (assuming product_ids is serialized)
  def add_product(product, quantity = 1)
    product_list = products_lists.find_or_initialize_by(product: product)

    Rails.logger.debug "Current quantity: #{product_list.quantity}, Adding: #{quantity}"

    product_list.quantity = (product_list.quantity || 0) + quantity
    product_list.save
  end


  def total_cost
    products_lists.joins(:product).sum('products_lists.quantity * products.price')
  end

  # To get products associated with the list
  def products
    Product.where(id: product_ids)
  end
end

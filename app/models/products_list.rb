class ProductsList < ApplicationRecord
  belongs_to :product
  belongs_to :list

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    product.price * quantity
  end
end

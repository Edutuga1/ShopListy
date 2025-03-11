module CategoriesHelper
  def product_is_seeded?(product)
    product.created_at < 1.hour.ago
  end
end

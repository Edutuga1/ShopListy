class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :products_lists
  has_many :lists, through: :products_lists
  validates :name, :price, :category_id, presence: true
  validates :user_id, presence: true
end

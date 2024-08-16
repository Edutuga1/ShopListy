# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :category

  has_many :items_lists
  has_many :lists, through: :items_lists

  # Add these lines if you have a Cart and CartItem model
  has_many :cart_items
  has_many :carts, through: :cart_items
end

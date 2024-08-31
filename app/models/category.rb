class Category < ApplicationRecord
  has_and_belongs_to_many :lists
  has_many :meat_products
  has_many :products
end

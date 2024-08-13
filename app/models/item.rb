class Item < ApplicationRecord
  belongs_to :category
  has_many :items_lists
  has_many :lists, through: :items_lists

  # Optionally, add validations
  validates :name, presence: true
end

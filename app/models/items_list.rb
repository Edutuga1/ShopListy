class ItemsList < ApplicationRecord
  belongs_to :list
  belongs_to :item

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :item, presence: true
end

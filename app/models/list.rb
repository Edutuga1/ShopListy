class List < ApplicationRecord
  belongs_to :user
  has_many :items_lists
  has_many :items, through: :items_lists

  # Optionally, add validations
  validates :name, presence: true
end

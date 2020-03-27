class Product < ApplicationRecord
  belongs_to :category

  validates :num, :name, :description, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true }

  # has_one_attached :image
end

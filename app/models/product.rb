# frozen_string_literal: true
class Product < ApplicationRecord
  belongs_to :brand
  has_many :cart_items, dependent: :destroy

  validates_presence_of :name, :model, :sku, :price
  validates :name, :model, :sku, length: { maximum: 255 }
  validates :sku, uniqueness: { case_sensitive: true }

  self.per_page = 20
end

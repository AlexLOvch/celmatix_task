# frozen_string_literal: true
class ProductDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :model, :sku, :price, :desc
  attribute :brand do
    object.brand.name
  end
end

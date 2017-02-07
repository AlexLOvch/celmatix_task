# frozen_string_literal: true
class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :model, :sku, :price
  attribute :brand do
    object.brand.name
  end
end

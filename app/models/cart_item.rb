# frozen_string_literal: true
class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.add(user, product)
    cart_item = find_by(user_id: user.id, product_id: product.id)
    if cart_item.present?
      cart_item.increment!(:quantity)
    else
      create!(user_id: user.id, product_id: product.id)
    end
  end

  def self.remove(user, product)
    cart_item = find_by(user_id: user.id, product_id: product.id)
    if cart_item.present? && cart_item.quantity > 1
      cart_item.decrement!(:quantity)
    elsif cart_item.present?
      cart_item.delete
    end
  end
end

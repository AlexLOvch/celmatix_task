# frozen_string_literal: true
class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

  before_save :downcase_email

  has_many :cart_items
  has_many :products, through: :cart_items

  def add_to_cart(product)
    CartItem.add(self, product)
  end

  def remove_from_cart(product)
    CartItem.remove(self, product)
  end

  protected

  def downcase_email
    self.email = email.delete(' ').downcase if email
  end
end

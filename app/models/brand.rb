# frozen_string_literal: true
class Brand < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception

  validates_presence_of :name
  validates :name, length: { maximum: 255 }
end

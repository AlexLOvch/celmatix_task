# frozen_string_literal: true
FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    brand
    model { Faker::Lorem.characters(10) }
    sku { Faker::Lorem.characters(20) }
    price { Faker::Commerce.price }
    desc { Faker::Lorem.characters(200) }
  end
end

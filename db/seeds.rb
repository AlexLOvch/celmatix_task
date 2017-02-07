# frozen_string_literal: true
products_arr = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'seeds/products.json')))['products']

products_arr.each do |product_hash|
  brand_name = product_hash['brand']
  brand = Brand.first_or_create(name: brand_name)
  Product.create(product_hash.merge('brand' => brand))
end

User.create(name: 'test', email: 'test@example.com', password: '12345678', password_confirmation: '12345678')

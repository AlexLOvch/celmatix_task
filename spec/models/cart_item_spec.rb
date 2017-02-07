# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:products) { create_list(:product, 2) }

  describe '#add' do
    it 'should create record for new product' do
      expect do
        CartItem.add(user, products[0])
        CartItem.add(user, products[1])
      end.to change { CartItem.count }.from(0).to(2)
    end

    it 'should not create record for existent product' do
      CartItem.add(user, products[0])
      expect do
        CartItem.add(user, products[0])
      end.to_not change { CartItem.count }
    end

    it 'should increment quantity for existent product' do
      CartItem.add(user, products[0])
      CartItem.add(user, products[0])
      CartItem.add(user, products[1])
      CartItem.add(user2, products[0])
      expect(CartItem.find_by(user_id: user.id, product_id: products[0].id).quantity).to eq 2
    end
  end

  describe '#remove' do
    it 'should delete record if only product' do
      CartItem.add(user, products[0])
      expect do
        CartItem.remove(user, products[0])
      end.to change { CartItem.count }.from(1).to(0)
    end

    it 'should not delete record for existent product' do
      CartItem.add(user, products[0])
      CartItem.add(user, products[0])
      expect do
        CartItem.add(user, products[0])
      end.to_not change { CartItem.count }
    end

    it 'should decrement quantity for existent product' do
      CartItem.add(user, products[0])
      CartItem.add(user, products[0])
      CartItem.add(user, products[1])
      CartItem.add(user2, products[0])

      CartItem.remove(user, products[0])
      expect(CartItem.find_by(user_id: user.id, product_id: products[0].id).quantity).to eq 1
    end
  end
end

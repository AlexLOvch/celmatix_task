# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Cart items API', type: :request do
  let!(:products) { create_list(:product, 2) }
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:auth_params) { { 'Authorization' => "Bearer #{create_token(user.id)}" } }

  describe 'GET /cart_items' do
    context 'then not authorized' do
      it 'returns 401' do
        get '/cart_items'
        expect(response).to have_http_status(401)
      end
    end

    context 'then authorized' do
      before do
        CartItem.add(user, products[0])
        CartItem.add(user, products[0])
        CartItem.add(user, products[1])
        CartItem.add(user2, products[0])
      end

      it 'returns status code 200' do
        get '/cart_items', headers: auth_params
        expect(response).to have_http_status(200)
      end

      it 'returns cart_items' do
        get '/cart_items', headers: auth_params
        expect(parsed_response_data).not_to be_empty
        expect(parsed_response_data.size).to eq(2)
      end

      it 'returns only added products' do
        get '/cart_items', headers: auth_params
        expect(parsed_response_data.map { |d| d['id'].to_i }).to eq([products[0].id, products[1].id])
      end

      it 'returns needed fields only' do
        get '/cart_items', headers: auth_params
        expect(parsed_response_data.first.keys).to eq(%w(id type attributes))
        expect(parsed_response_data.first['attributes'].keys).to eq(%w(name model sku price brand))
      end
    end
  end
end

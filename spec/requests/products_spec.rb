# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let!(:products) { create_list(:product, 50) }
  let(:product_id) { products.first.id }

  describe 'GET /products' do
    it 'returns products' do
      get '/products'
      expect(parsed_response_data).not_to be_empty
      expect(parsed_response_data.size).to eq(20)
    end

    it 'returns status code 200' do
      get '/products'
      expect(response).to have_http_status(200)
    end

    it 'returns only records from selected page' do
      get '/products', params: { page: { number: 2 } }
      expect(parsed_response_data.map { |d| d['id'].to_i }).to eq(products.reverse[20..39].map(&:id))
    end

    it 'returns needed fields only' do
      get '/products', params: { page: { number: 2 } }
      expect(parsed_response_data.first.keys).to eq(%w(id type attributes))
      expect(parsed_response_data.first['attributes'].keys).to eq(%w(name model sku price brand))
    end

    it 'returns meta according selected page' do
      get '/products', params: { page: { number: 2 } }
      expect(parsed_response_meta).to eq(
        'current-page' => 2,
        'next-page' => 3,
        'prev-page' => 1,
        'total-count' => 50,
        'total-pages' => 3
      )
    end
  end

  describe 'GET /products/:id' do
    before { get "/products/#{product_id}" }

    context 'when the record exists' do
      it 'returns needed product' do
        expect(parsed_response_data).not_to be_empty
        expect(parsed_response_data['id'].to_i).to eq(product_id)
      end

      it 'returns all needed product attributes' do
        expect(parsed_response_data).not_to be_empty
        expect(parsed_response_data['attributes'].keys).to eq(%w(name model sku price desc brand))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end
end

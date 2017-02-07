# frozen_string_literal: true
class ProductsController < ApplicationController
  # GET /products
  def index
    @products = Product.order(created_at: :desc).page(params[:page] ? params[:page][:number] : 1)
    json_response(@products, meta: pagination_meta(@products))
  end

  # GET /products/:id
  def show
    @product = Product.find(params[:id])
    json_response(@product, serializer: ProductDetailSerializer)
  end

  private

  def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end
end

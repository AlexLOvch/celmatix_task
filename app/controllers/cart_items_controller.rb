# frozen_string_literal: true
class CartItemsController < ApplicationController
  include Authentication

  def index
    json_response(@current_user.products)
  end

  def create
    if params[:product_id] && product = Product.find(params[:product_id])
      @current_user.add_to_cart(product)
      # response w/ users product list each time to prevent oudated data in case simultaneous using several devices
      json_response(@current_user.products)
    else
      json_response({ error: 'unknown product' }, status: :bad_request)
    end
  end

  def destroy
    if params[:id] && product = Product.find(params[:id])
      @current_user.remove_from_cart(product)
      # response w/ users product list each time to prevent oudated data in case simultaneous using several devices
      json_response(@current_user.products)
    else
      json_response({ error: 'unknown product' }, status: :bad_request)
    end
  end
end
